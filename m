Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4816596EC
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiL3JpB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 04:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiL3Jo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 04:44:59 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994091A3BB;
        Fri, 30 Dec 2022 01:44:58 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 18so1984661pfx.7;
        Fri, 30 Dec 2022 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsxWU+7JXoo0HKla64t5E5/IriNtkmkOsQcwskb5TXQ=;
        b=mcD3qMK0skxweug7P1cOb0vrwaNOmLXOoUYzKN5qSYfC5mnPY7MnX2dDHSwP3PLZ2R
         HFDBoaEiY9RuBwGhORAcjjXu0GW2KWBYAANLo2kYZpjCu/Beyt9Ac18MsogHnsby/o1Z
         WK5s6Psbp+tw7aqNUFR5YQNNVZvLFGr5vEkG+CWTXM2wroPzedJcp0jp+D5qHRBQcXqG
         Q4xKtoj2uiD94qlcRILS9TQbLqAQO6M6qbrOR4F4ndvJo9729Gc+CCr7Kjsmv1XFZsQD
         jhqpOMN1bMwo1tN7EJB7lIy9an7wsgefxDmlS7BnDcjforjJUS53+NlAhdYFKZjWuTNC
         6c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsxWU+7JXoo0HKla64t5E5/IriNtkmkOsQcwskb5TXQ=;
        b=hIANinVosshu7PlKse009VYYmcv6FsEsK9kor9Uc0piuMMz1nNhl61xbEA01esUvaz
         5zUnCRCMrMdSIIMyEbU5neGv2hFEzdsLwOozIVzNh7DrXiQvP3Kln9qEumcPERQFG6H5
         tGDgm/1ReFlZ11XQfCiZkKqgMVs0v6DngO6L8hKysuxl7WxZpjX5ypJq0HpTH+6pe4dn
         rj6O5F7yPzC+5GEmk6D4Bvpk5asU6moTJcS4xl1pf6i5fTGMXRy2YTM4K/4F0FCGIXoh
         EH5i/ecXIIHnujSDyaIxkXPLDrm3Yd6GV64RFiodGZ9EeF7/IM2tymQVQ/aA7oHV2m6B
         nXNQ==
X-Gm-Message-State: AFqh2kpyJnYroEM9TVj26/78walzdxjnGfyQsi65LXp/A4QntquAEZId
        EqLUygYMP9wMDYq/KP66Pg==
X-Google-Smtp-Source: AMrXdXvBZxNV4/WpuHBV4rHRrG+3YpUxsZePqSHms11ehR5JSbCWSQWZ4iIaHXWqhZV4hBA5G6Ne+w==
X-Received: by 2002:a05:6a00:27a0:b0:57f:cf88:edf5 with SMTP id bd32-20020a056a0027a000b0057fcf88edf5mr42243045pfb.24.1672393498010;
        Fri, 30 Dec 2022 01:44:58 -0800 (PST)
Received: from smtpclient.apple ([144.214.0.13])
        by smtp.gmail.com with ESMTPSA id d63-20020a623642000000b005821156cd70sm205594pfa.190.2022.12.30.01.44.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Dec 2022 01:44:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: WARNING in __mark_chain_precision
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <CAEf4BzY-DMVEpy+mPTObEO56E7=fzqab8zW_4JyBeyGtTqqcXg@mail.gmail.com>
Date:   Fri, 30 Dec 2022 17:44:43 +0800
Cc:     Yonghong Song <yhs@meta.com>, Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29B647B3-174A-4BE7-9E0E-83AE94B0EADF@gmail.com>
References: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
 <Y6C36gvJ2JnwKm3X@google.com>
 <CAEf4BzbY8SDL04W_3Vot6iiYu69Lqg9W9aMCp26+RwLBh6C_0g@mail.gmail.com>
 <ba5aacc8-7e10-e20a-936b-f3f81d7fcf03@meta.com>
 <CAEf4BzY-DMVEpy+mPTObEO56E7=fzqab8zW_4JyBeyGtTqqcXg@mail.gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=
=8830=E6=97=A5=E5=91=A8=E4=BA=94 06:16=E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Dec 27, 2022 at 9:24 PM Yonghong Song <yhs@meta.com> wrote:
>>=20
>>=20
>>=20
>> On 12/20/22 4:30 PM, Andrii Nakryiko wrote:
>>> On Mon, Dec 19, 2022 at 11:13 AM <sdf@google.com> wrote:
>>>>=20
>>>> On 12/19, Hao Sun wrote:
>>>>> Hi,
>>>>=20
>>>>> The following backtracking bug can be triggered on the latest =
bpf-next and
>>>>> Linux 6.1 with the C prog provided. I don't have enough knowledge =
about
>>>>> this part in the verifier, don't know how to fix this.
>>>>=20
>>>> Maybe something related to commit be2ef8161572 ("bpf: allow =
precision
>>>> tracking
>>>> for programs with subprogs") and/or the related ones?
>>>>=20
>>>>=20
>>>>> This can be reproduced on:
>>>>=20
>>>>> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to =
locate
>>>>> libelf
>>>>> git tree: bpf-next
>>>>> console log: https://pastebin.com/raw/45hZ7iqm
>>>>> kernel config: https://pastebin.com/raw/0pu1CHRm
>>>>> C reproducer: https://pastebin.com/raw/tqsiezvT
>>>>=20
>>>>> func#0 @0
>>>>> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>>>>> 0: (18) r2 =3D 0x8000000000000          ; R2_w=3D2251799813685248
>>>>> 2: (18) r6 =3D 0xffff888027358000       ;
>>>>> R6_w=3Dmap_ptr(off=3D0,ks=3D3032,vs=3D3664,imm=3D0)
>>>>> 4: (18) r7 =3D 0xffff88802735a000       ;
>>>>> R7_w=3Dmap_ptr(off=3D0,ks=3D156,vs=3D2624,imm=3D0)
>>>>> 6: (18) r8 =3D 0xffff88802735e000       ;
>>>>> R8_w=3Dmap_ptr(off=3D0,ks=3D2396,vs=3D76,imm=3D0)
>>>>> 8: (18) r9 =3D 0x8e9700000000           ; R9_w=3D156779191205888
>>>>> 10: (36) if w9 >=3D 0xffffffe3 goto pc+1
>>>>> last_idx 10 first_idx 0
>>>>> regs=3D200 stack=3D0 before 8: (18) r9 =3D 0x8e9700000000
>>>>> 11: R9_w=3D156779191205888
>>>>> 11: (85) call #0
>>>>> 12: (cc) w2 s>>=3D w7
>>>=20
>>> w2 should have been set to NOT_INIT (because r1-r5 are clobbered by
>>> calls) and rejected here as !read_ok (see check_reg_arg()) before
>>> attempting to mark precision for r2. Can you please try to debug and
>>> understand why that didn't happen here?
>>=20
>> The verifier is doing the right thing here and the 'call #0' does
>> implicitly cleared r1-r5.
>>=20
>> So for 'w2 s>>=3D w7', since w2 is used, the verifier tries to find
>> its definition by backtracing. It encountered 'call #0', which clears
>=20
> and that's what I'm saying is incorrect. Normally we'd get !read_ok
> error because s>>=3D is both READ and WRITE on w2, which is
> uninitialized after call instruction according to BPF ABI. And that's
> what actually seems to happen correctly in my (simpler) tests locally.
> But something is special about this specific repro that somehow either
> bypasses this logic, or attempts to mark precision before we get to
> that test. That's what we should investigate. I haven't tried to run
> this specific repro locally yet, so can't tell for sure.
>=20

So, the reason why w2 is not marked as uninit is that the kfunc call in
the BPF program is invalid, "call #0", imm is zero, right?
In check_kfunc_call(), it skips this error temporarily:

/* skip for now, but return error when we find this in fixup_kfunc_call =
*/
 if (!insn->imm)
 return 0;

So the kfunc call is the previous instruction before "w2 s>>=3D w7", =
this
leads to the warning in backtrack_insn():

/* regular helper call sets R0 */
*reg_mask &=3D ~1;
if (*reg_mask & 0x3f) {
	/* if backtracing was looking for registers R1-R5
	* they should have been found already.
	*/
	verbose(env, "BUG regs %x\n", *reg_mask);
	WARN_ONCE(1, "verifier backtracking bug=E2=80=9D);
	return -EFAULT;
}

Any idea or hint on how to fix this?

