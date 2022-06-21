Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A62553DD1
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 23:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353576AbiFUVaY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356574AbiFUVaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 17:30:13 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC781B35
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 14:28:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 43so22387743qvb.3
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AZUS/g5bWg4lEj+kmZCythqQCah4jQbHqFN301nK9c=;
        b=15Wz7A1zHj+F9i6THhmo+vyk4rxSbuCZXurOJ4knvKUkhyk6q4pOWqS/OCj6Gh33g0
         zmoRPmgjjn5D886yqkRBPJoft9b6rnWWTFnzWvssNvexV104OV+2z5opZ9/ybLUy5inp
         WZ4avSDD6qRQzTFdO+xu+23qpF2gf5RKzZWrEkPlCOmAtbe/ND02XE2aZq7TERYVLsFv
         IbcMj86QlPtKMKigc/vTnj7uK9krnMjD9IDPcHaRAImRB52EECVlwZ/P/3ZS93nOaUYm
         Fr16+XNoM6u7+FGC1agk5hIVdB4HdL0hvWygWlbuIj6FDNhUNjURTxYWGPyA88ELt8Yy
         l6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AZUS/g5bWg4lEj+kmZCythqQCah4jQbHqFN301nK9c=;
        b=0lGrhE0Wabxz9wJ3ZPiDTo91Vws3iDRoyqSFb0YiJQy67neEy/p97UU1JQVUONL7zn
         2TTfhCI1GkKBX9Xw1m9/TR/UNvYRs6D1E8AZb2jrM8WNl64wpLYOwRGmtIcb+8GKzwh2
         U+3V2+IbX1B3c/N1aiG9QGVkeiUxLUt0K8Z80PMQRuWvhrNnTlyHH79MmhsAmGtuSp7z
         5zg5Jg/UAcfaAKEFMpsc18813g2NQrbPANUbbvPj7vECEuqfsCP/v3LubPzcfqeGAhOa
         +raJxyjQ2taXvPBbsZ4tkPeFLeAC0lwHrJRNIHOYnOYl+xQwNrz7B2+U+2RNe/kaTNDT
         htNg==
X-Gm-Message-State: AJIora8/hwDT9O+CLUHPRMYvQX6gexAZRbsH9MI51bHrHoANxkCq5pm+
        7I7ctPi5B3EwsO4wnY3V/6s2KSPC0PQ+QvUQyyh0sBxs97ktxw==
X-Google-Smtp-Source: AGRyM1ut4SKi80TuhLtfdpfD+xs2d+d7jfBtnJegix4N0MqribsZnEVM5F/3Hrvf3E+/StWZVFyy2QAQF4KY06QyEO0=
X-Received: by 2002:ac8:5b51:0:b0:304:f6e3:8b36 with SMTP id
 n17-20020ac85b51000000b00304f6e38b36mr290716qtw.522.1655846918927; Tue, 21
 Jun 2022 14:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <YrEoRyty7decoMhh@Laptop-X1>
In-Reply-To: <YrEoRyty7decoMhh@Laptop-X1>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 21 Jun 2022 22:28:27 +0100
Message-ID: <CACdoK4JrrVoMjvwQusdpYOO5gDqZDKky2QZqyb08p+2R1186Gw@mail.gmail.com>
Subject: Re: How about adding a name for bpftool self created maps?
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Yauheni Kaliuta <ykaliuta@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 21 Jun 2022 at 03:09, Hangbin Liu <liuhangbin@gmail.com> wrote:
>
> Hi Quentin,
>
> When I using `bpftool map list` to show what maps user using. bpftool will
> show maps including self created maps. Apart from the "pid_iter.rodata",
> there are also array maps without name, which makes it hard to filter out
> what maps user using. e.g.
>
> # bpftool map list
> 63: array  flags 0x0
>          key 4B  value 32B  max_entries 1  memlock 4096B
> 65: array  name pid_iter.rodata  flags 0x480
>          key 4B  value 4B  max_entries 1  memlock 4096B
>          btf_id 98  frozen
>          pids bpftool(10572)
> 66: array  flags 0x0
>          key 4B  value 32B  max_entries 1  memlock 4096B
>
> So do you have plan to add a special name for the bpftool self created maps?
> Or do you know if there is a way to filter out these maps?

Hi Hangbin,

No plan currently. Adding names has been suggested before, but it's
not compatible with some older kernels that don't support map names
[0]. Maybe one solution would be to probe the kernel for map name
support, and to add a name if supported.

Other than this I'm not aware of a reliable way to filter out these
maps at the moment. This could probably be done in bpftool since we
should have the ids of the self-generated maps. But I think I'd rather
find a way to add map names, if possible. It would make it easier to
recognise/filter these maps on regular listing, whereas a new option
would be harder for users to discover.

Quentin

[0] https://lore.kernel.org/bpf/CAEf4BzY66WPKQbDe74AKZ6nFtZjq5e+G3Ji2egcVytB9R6_sGQ@mail.gmail.com/
