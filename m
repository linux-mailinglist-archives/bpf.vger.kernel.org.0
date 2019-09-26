Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA54ABF133
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2019 13:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfIZLXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Sep 2019 07:23:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39936 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbfIZLXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Sep 2019 07:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569497025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RNd7iyl5zD3WAVj2sWBbz2iZKaZZld288UAKSsgCxlk=;
        b=ZGJBie6ii/hU/3Q/DZAZD6anNJbhkqSrZ9AMkkZ0d7Dlg0i59qmWc0tWxHYuH7+XPcpdJx
        TG1YtAS7tKd2Ljo5stsgNGp2xrQPbDVqDHUL7aJK2vsu5XUElR+UvD7u2i9eL/ClD6Wp/H
        4RO/uD+b3IANH6D9lauTjo9uUPabff4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258--DHPP35QP7ScpkvyNbDmpg-1; Thu, 26 Sep 2019 07:23:41 -0400
Received: by mail-ed1-f72.google.com with SMTP id 38so1140669edr.4
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2019 04:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=RNd7iyl5zD3WAVj2sWBbz2iZKaZZld288UAKSsgCxlk=;
        b=foW7ksfxbcxEIRLY3FoNZwjd3anOddX01vDM6SCKAK9LQMld78cr7nj5uUNnKGzfFp
         5mC8WZX+DPve2QDZsFNpu0Hllis+X7y91XyBBPnCDzjC8NfeDnyBN3waOXjT4211q5yb
         bESub3JOAodAAdTglG/yU+Ykxx7h+dlJ5cpKEHH0i0EV2j/AebRr/O6W2M/Qb60RRctS
         jKLg0kLT0luFfxhuEumaKp3KOstsshujdtaTTwtncuXw9xsJtR00aq3iEBQnOTcqWG+q
         BVnwg9iMTd+EwMHgC4b1kqq+fCTmp2aqKhdtRZX1yKW6/C4Y5EvHhQj76ZnRabtMnl9w
         YUZQ==
X-Gm-Message-State: APjAAAXFj2IouqRLBgk2A+lIFU4dRB3+7te6QLBDWZVB9UOaT9bL0cVB
        caa5nj07h2pc90/zPcLqfxvBkEEB2DOkKL8Kep1ichT9INEe4eltnmfUyHGmY17J9IkqxvYDnrk
        1xYTTJWQCk457
X-Received: by 2002:a17:906:1941:: with SMTP id b1mr2499499eje.141.1569497020705;
        Thu, 26 Sep 2019 04:23:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwnmHU7Pe4fZknsumAAwCS9kWPgsn7D6xQuxdKuOxWv9QofZpL15PlmzctUYEylYBPT1hFFYg==
X-Received: by 2002:a17:906:1941:: with SMTP id b1mr2499484eje.141.1569497020443;
        Thu, 26 Sep 2019 04:23:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id g15sm414861edp.0.2019.09.26.04.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 04:23:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D09B818063D; Thu, 26 Sep 2019 13:23:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Are BPF tail calls only supposed to work with pinned maps?
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Sep 2019 13:23:38 +0200
Message-ID: <874l0z2tdx.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: -DHPP35QP7ScpkvyNbDmpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel

While working on a prototype of the XDP chain call feature, I ran into
some strange behaviour with tail calls: If I create a userspace program
that loads two XDP programs, one of which tail calls the other, the tail
call map would appear to be empty even though the userspace program
populates it as part of the program loading.

I eventually tracked this down to this commit:
c9da161c6517 ("bpf: fix clearing on persistent program array maps")

Which clears PROG_ARRAY maps whenever the last uref to it disappears
(which it does when my loader exits after attaching the XDP program).

This effectively means that tail calls only work if the PROG_ARRAY map
is pinned (or the process creating it keeps running). And as far as I
can tell, the inner_map reference in bpf_map_fd_get_ptr() doesn't bump
the uref either, so presumably if one were to create a map-in-map
construct with tail call pointer in the inner map(s), each inner map
would also need to be pinned (haven't tested this case)?

Is this really how things are supposed to work? From an XDP use case PoV
this seems somewhat surprising...

Or am I missing something obvious here?

-Toke

