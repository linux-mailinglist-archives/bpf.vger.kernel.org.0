Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491B2281125
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 13:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgJBLYT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgJBLYT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 07:24:19 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F706C0613D0
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 04:24:19 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id z1so249815ooj.3
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dv3HKd8zy94ZpSaGbY+eVG6xyzqnD4KZkkkXQHzpkuQ=;
        b=hcp4q/ACPbT7n4QD6ASnRJHMzy2Hvzac6M5qLqu0OZBeBI/cXXVcTIpQwVZped2uF6
         llVKuFRyULDShMco3rKVPxKInuPZPJGjA5SRoc7d5bqv15SISEKdGWugkf8L1sKJtpg4
         3Z4FKiUYy6GHuAHR5+bhTtY2ol0UCmqYMdI6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dv3HKd8zy94ZpSaGbY+eVG6xyzqnD4KZkkkXQHzpkuQ=;
        b=U1c5aixfiViLPL7rykv/pX03J9K5w7L1xQxOtZg9ku7uQAsQkvG3PcEmkpXZQnSjJH
         CeykTyU6WRNjSFljweyC2X/0zHot6r8doER8pawYttj/4JnbgyH/M+SEtzzPxCYna728
         pur51qApG052w96ufeg3JkEI9M+mRzzt7oyt4fvnRj9oxEOqWALvMiWlevdx3mhsTLfv
         oznETaphV6DnepcTvRERriBAwrgmCqH+KpepwEhTEy41sDC5s44zIn09iH+n3evOaotS
         I9LqF9fUzyGCtEFrIjYppNWjOYgcGZuUJ0/VB/XNlMg/jcG/so77Ec0lSG6i3lSr3Zxv
         d6nA==
X-Gm-Message-State: AOAM5321Ic4a3+TLQEkTpDwJhMenY/KI00+Ir+Yg+7wpYGvpzUrIibW5
        AVkF1NyeEnOL3RAN+st9YbG4Ui4y2myvRZvnsOjGCWKWfaH8eGyc
X-Google-Smtp-Source: ABdhPJw1cMiBwNn6jh/GZTyRe4klu1d1HLg+p6tQr+eWO4omY9Epfio90mrSRScA/Di/qN5Jg0H/3hFd2th1gQmjdQM=
X-Received: by 2002:a4a:81:: with SMTP id 123mr1499103ooh.80.1601637858512;
 Fri, 02 Oct 2020 04:24:18 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 2 Oct 2020 12:24:07 +0100
Message-ID: <CACAyw9_R4_ib0KvcuQC4nSOy5+Hn8-Xq-G8geDdLsNztX=0Fsw@mail.gmail.com>
Subject: BTF CO-RE bitfield relocation: why is the load size rounded?
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

I'm trying to understand the following code from
bpf_core_calc_field_relo in libbpf.c:

    if (bitfield) {
        byte_sz = mt->size;
        byte_off = bit_off / 8 / byte_sz * byte_sz;
        /* figure out smallest int size necessary for bitfield load */
        while (bit_off + bit_sz - byte_off * 8 > byte_sz * 8) {
            if (byte_sz >= 8) {
                ...
                return -E2BIG;
            }
            byte_sz *= 2;
            byte_off = bit_off / 8 / byte_sz * byte_sz;
        }
    }

It's used to calculate the load size (byte_sz) and load offset
(byte_off) for a bitfield member of a struct. Can you explain to me
why byte_off is rounded to byte_sz? Is it to preserve alignment?

It seems like the rounding can lead to reading past the end of a
struct. An example:

    struct foo {
        unsigned short boo:4;
    } __attribute__((packed));

    [2] STRUCT 'foo' size=1 vlen=1
        'boo' type_id=3 bits_offset=0 bitfield_size=4
    [3] INT 'unsigned short' size=2 bits_offset=0 nr_bits=16 encoding=(none)

The result of the calculation for this is byte_sz = 2 and byte_off =
0, but the structure is only 1 byte in length.

Would it be possible to replace the calculation with the following?

    byte_off = bit_off / 8
    byte_sz = ((bit_off + bit_sz + 7) - byte_off*8) / 8

Thanks
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
