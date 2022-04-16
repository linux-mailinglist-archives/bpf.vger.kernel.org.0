Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA25037CA
	for <lists+bpf@lfdr.de>; Sat, 16 Apr 2022 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiDPSEK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Apr 2022 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbiDPSEJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 14:04:09 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B23ED0E
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 11:01:37 -0700 (PDT)
Date:   Sat, 16 Apr 2022 18:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1650132095;
        bh=OquphsZ+ID6bDBTox3EOTHfeuB/3SdhPpYZE8tPYqUU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=GBou8tjSh7Mr8le+xfA77YhAhJxyZKeXcnoxYLuxyTsF9gyPB086VtvL6kRWuEk/H
         F6ZDQJij52BK1KoNRnGHmHO4q5NGJTGWb42/xR/5tbATjAmUp/slwsNBxo4J0pWwTF
         fnD7oK5Q5xqY/dT0Pyhayct4UTZymLgt5XefZjiwK4ncto/V1nSDNE0Zd+y4vgH7KJ
         zzFk70UL7eHCrCQUYHMKpfRsGoqIBEwY7xE7dDldkqQEI/7rff1i+tLZp8PGmF9hFJ
         7UKjDgQlrF+DtRTdmgMML7fR/zTz9fdhqiW0O01pkHgxixrdCSNSE2VJ9y8f7Ys6s/
         NgRJVcWF8fXZg==
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH bpf-next 00/11] bpf: random unpopular userspace fixes (32 bit et al.)
Message-ID: <20220416175452.202686-1-alobakin@pm.me>
In-Reply-To: <CAADnVQ+rGR9vaDD1GM3mPgTkece711KZ+ME1MPWN8KYohydZyQ@mail.gmail.com>
References: <20220414223704.341028-1-alobakin@pm.me> <CAADnVQ+rGR9vaDD1GM3mPgTkece711KZ+ME1MPWN8KYohydZyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Apr 2022 00:50:49 +0000

> On Thu, Apr 14, 2022 at 3:44 PM Alexander Lobakin <alobakin@pm.me> wrote:
>
> Please do not send encrypted patches.
> Use plain text.

Oof, weird. I use ProtonMail Bridge and they claim it doesn't
encrypt mails to non-Proton users. That's the first time I hear
such, I was sending several fixes to LKML a couple weeks ago
from this mail address with no issues (and got them accepted).

>
> Also for bpf fixes please use [PATCH bpf] subject.

I decided to go with bpf-next since it changes the layout of
&perf_event a bit when !CONFIG_PERF_EVENTS. But if you're okay
with taking this through the bpf tree, it's even better.

> cc maintainers and bpf@vger only.
> There is no need to spam such a huge list of people.

I usually redirect scripts/get_maintainers.pl to git-send-email
directly, but you're right, sure. Seems like it does overkills
sometimes.

Thanks,
Al

