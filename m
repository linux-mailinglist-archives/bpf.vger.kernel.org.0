Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B57F4D5403
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 22:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiCJV7G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 16:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiCJV7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 16:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA940A1BF8
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646949481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyYbSMNDIkgLbz7yvi2HvYsU8igcLdYIMzghnDnn36s=;
        b=hTieMZ/4GO8gQCykeEQc1fLkJi9+tlafoaRKVGKtxiBUItkh1RfJEugH72R1qKPnCFn1uQ
        CoHtqRQAJP8KijFOaw6UjONZWbrrN4Dd2OGrJCuAeic8unqPjnZoOiD7qs980UlKf8Wwm4
        pp+9JBbutlcaTBrPjZZ/4cuLYKntWxg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-IrjcMI0bMJOkVoN_TBYC7A-1; Thu, 10 Mar 2022 16:57:59 -0500
X-MC-Unique: IrjcMI0bMJOkVoN_TBYC7A-1
Received: by mail-ed1-f69.google.com with SMTP id u28-20020a50d51c000000b004159ffb8f24so3840142edi.4
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 13:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wyYbSMNDIkgLbz7yvi2HvYsU8igcLdYIMzghnDnn36s=;
        b=shXTzXcQoDaV6PdlLm8znSoPr5oG8q5RvsawPZP37ZR6u4I65KbUOIa0hm1QACf5Oy
         7M/Nr8ITMOgkbU+Klc45UGqWpv+gWPOo77xI/7y/Xec4NDdAt6TrnUmdbRZ5YUU6W99H
         q1xtnZmoNIZnS7KKfd5V0lbKv4Xv/fuCLnhVGJec8UE/46TAt4PXrNfeEMb/6FmalklD
         TF7HIgSe4Ysu8F1O+HgaXA+vpYjw1HTfY/7LuaaY0KRix0Aitqom6pxmp2H56qCQobxN
         4D+zcVbA/Gb4csx850guz2WnWltmPF89hNl48VmC0lN69bA0GnuO/jTH3CHnbmwcV1KL
         6czw==
X-Gm-Message-State: AOAM531Y6CWchl7I9d6y3G8xpBwYdVetVd8VBjNbyaRoC28DSGBklrIf
        XB2Lncql+Oj8GDl+CYb031W8J3ahxv+h1KoC2KtasRK+n2qqcFWnHTM5OxKEJPq0pNOvT5TWmWA
        UihCvt28aYhEd
X-Received: by 2002:a05:6402:34cb:b0:415:b974:ec5c with SMTP id w11-20020a05640234cb00b00415b974ec5cmr6424354edc.329.1646949474988;
        Thu, 10 Mar 2022 13:57:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3J07rWqPVHpRbRgAfNIsa2YEkK9fYYXo5WB/bsFY89DjXNQc74Jsib2unZpspwGd+tFoaoQ==
X-Received: by 2002:a05:6402:34cb:b0:415:b974:ec5c with SMTP id w11-20020a05640234cb00b00415b974ec5cmr6424283edc.329.1646949473831;
        Thu, 10 Mar 2022 13:57:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906521000b006d58773e992sm2222909ejm.188.2022.03.10.13.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 13:57:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 74D661A8990; Thu, 10 Mar 2022 22:57:52 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        syzbot <syzbot+0e91362d99386dc5de99@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: missing reserved tailroom
In-Reply-To: <20220310210626.25o2mll3jmp62swy@kafai-mbp.dhcp.thefacebook.com>
References: <00000000000019c51e05d9e18158@google.com>
 <20220310210626.25o2mll3jmp62swy@kafai-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 10 Mar 2022 22:57:52 +0100
Message-ID: <87ee39xyfz.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <kafai@fb.com> writes:

> On Thu, Mar 10, 2022 at 10:37:20AM -0800, syzbot wrote:
>> Hello,
>>=20
>> syzbot found the following issue on:
>>=20
>> HEAD commit:    de55c9a1967c Merge branch 'Add support for transmitting =
pa..
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ce88ad7000=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2fa13781bcea=
50fc
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0e91362d99386d=
c5de99
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binut=
ils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11f3634570=
0000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14c8ca657000=
00
>>=20
>> The issue was bisected to:
>>=20
>> commit b530e9e1063ed2b817eae7eec6ed2daa8be11608
>> Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Date:   Wed Mar 9 10:53:42 2022 +0000
>>=20
>>     bpf: Add "live packet" mode for XDP in BPF_PROG_RUN
>>=20
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17696e557=
00000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14e96e557=
00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10e96e557000=
00
>>=20
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+0e91362d99386dc5de99@syzkaller.appspotmail.com
>> Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RU=
N")
>>=20
>> ------------[ cut here ]------------
>> XDP_WARN: xdp_update_frame_from_buff(line:274): Driver BUG: missing rese=
rved tailroom
>> WARNING: CPU: 0 PID: 3590 at net/core/xdp.c:599 xdp_warn+0x28/0x30 net/c=
ore/xdp.c:599
> Toke, please take a look.

Right, I see the problem; will send a fix!

-Toke

