Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A802065C63C
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjACS2K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 13:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjACS2H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 13:28:07 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B38F286;
        Tue,  3 Jan 2023 10:28:05 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fy8so12109237ejc.13;
        Tue, 03 Jan 2023 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNwf51jFGozJ+vLd0lHheWcwqpF2RrsuMNJx7eGeCvo=;
        b=N8R6SWh2T6Zz3rs8LIvrM0NyBe+rBlSanLz056pU4ok/Hh6ZCpRd4LWYhEQcDJgTiB
         pefbwqkuliCxNs3fRHqTGZ0a68k86MBhAL4l834JOqyuMj+z97IDYvQfN4ZuPemigDPs
         GYg2eUEL6j6kgJX+v9wP+Qfkec8/GsuUeNMT3+uS7q7q2NmSxmxSfBA2hEvakhCfdP1G
         /VSQ2moNxFZ+ssJtjfKAZF8vaotq2knmUI7lgDwv7kAHx8skoAX7E8Zj+aAH+9gOYRlG
         4v71CIQxLTxu2sdey2zhJasAqcuYR1ASz15gSIAs9vNzTSshBP586cgRrrUiZ9sexMR7
         NAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNwf51jFGozJ+vLd0lHheWcwqpF2RrsuMNJx7eGeCvo=;
        b=Zt+HMz2fdlXUW/NuAJDODtnmMUKYFX7YOjgFvnVEA17Po2WGkbw9GvikZlDrne9zaY
         Ht7oM214kVG2RAMOQ26uXUu9VL+1Nm/fkZVbD2/hwqjQMhUrppVDNqfkjkwkzFmiOGYo
         NQSJJf/B5UErnVsR1ih7Itqwn+OQ955HPwD6MCcXbsFWvzSmky5xcQd20kHDRkfR3HeE
         8qfo1BouWkNU3BccXfWxGTZlJxqCnl6ML2tnEnuvT375dMTHvgefMKRH+XbolTLhbGc1
         zFPQZI/I/EK7+zL5uUlbuvCHA9/3XiEdPYbPzG9hgePXeNaAaPW6m6fNd0l4B249iQcn
         pqpA==
X-Gm-Message-State: AFqh2koasSsX4CMkolDY9j68/gDmrufMkFJy5UJ2qNA49ixa43UXIt1p
        06QDBGYcHnRf9NYFtqlq7MivMeCxErVdZmMI3Eo=
X-Google-Smtp-Source: AMrXdXtLPRguauqmjZTgyUatA/3L8lTBU3euq1B1fqBUm3FYI6mObXu678/hSdVdorP3Ngtdd/gUG94iOfT3enEXirQ=
X-Received: by 2002:a17:906:a18c:b0:7c0:f2cf:3515 with SMTP id
 s12-20020a170906a18c00b007c0f2cf3515mr2954863ejy.327.1672770483836; Tue, 03
 Jan 2023 10:28:03 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
 <Y6C36gvJ2JnwKm3X@google.com> <CAEf4BzbY8SDL04W_3Vot6iiYu69Lqg9W9aMCp26+RwLBh6C_0g@mail.gmail.com>
 <ba5aacc8-7e10-e20a-936b-f3f81d7fcf03@meta.com> <CAEf4BzY-DMVEpy+mPTObEO56E7=fzqab8zW_4JyBeyGtTqqcXg@mail.gmail.com>
 <29B647B3-174A-4BE7-9E0E-83AE94B0EADF@gmail.com> <04c66278-b044-98e4-2861-218bd159bd15@meta.com>
 <CB67D529-B384-4B1C-AC01-DD99D4F6DEA5@gmail.com>
In-Reply-To: <CB67D529-B384-4B1C-AC01-DD99D4F6DEA5@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 3 Jan 2023 10:27:52 -0800
Message-ID: <CAADnVQKy48LPz=f6XSHv84tZb7MFp8PrWrk3AxJLKwJR0tL=nA@mail.gmail.com>
Subject: Re: WARNING in __mark_chain_precision
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Yonghong Song <yhs@meta.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 2, 2023 at 1:42 AM Hao Sun <sunhao.th@gmail.com> wrote:
>
>
>
> Yonghong Song <yhs@meta.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=B8=80 03:20=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> > On 12/30/22 1:44 AM, Hao Sun wrote:
> >>
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2022=E5=B9=B412=
=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 06:16=E5=86=99=E9=81=93=EF=BC=9A
> >>>
> >>> On Tue, Dec 27, 2022 at 9:24 PM Yonghong Song <yhs@meta.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 12/20/22 4:30 PM, Andrii Nakryiko wrote:
> >>>>> On Mon, Dec 19, 2022 at 11:13 AM <sdf@google.com> wrote:
> >>>>>>
> >>>>>> On 12/19, Hao Sun wrote:
> >>>>>>> Hi,
> >>>>>>
> >>>>>>> The following backtracking bug can be triggered on the latest bpf=
-next and
> >>>>>>> Linux 6.1 with the C prog provided. I don't have enough knowledge=
 about
> >>>>>>> this part in the verifier, don't know how to fix this.
> >>>>>>
> >>>>>> Maybe something related to commit be2ef8161572 ("bpf: allow precis=
ion
> >>>>>> tracking
> >>>>>> for programs with subprogs") and/or the related ones?
> >>>>>>
> >>>>>>
> >>>>>>> This can be reproduced on:
> >>>>>>
> >>>>>>> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to=
 locate
> >>>>>>> libelf
> >>>>>>> git tree: bpf-next
> >>>>>>> console log: https://pastebin.com/raw/45hZ7iqm
> >>>>>>> kernel config: https://pastebin.com/raw/0pu1CHRm
> >>>>>>> C reproducer: https://pastebin.com/raw/tqsiezvT
> >>>>>>
> >>>>>>> func#0 @0
> >>>>>>> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> >>>>>>> 0: (18) r2 =3D 0x8000000000000          ; R2_w=3D2251799813685248
> >>>>>>> 2: (18) r6 =3D 0xffff888027358000       ;
> >>>>>>> R6_w=3Dmap_ptr(off=3D0,ks=3D3032,vs=3D3664,imm=3D0)
> >>>>>>> 4: (18) r7 =3D 0xffff88802735a000       ;
> >>>>>>> R7_w=3Dmap_ptr(off=3D0,ks=3D156,vs=3D2624,imm=3D0)
> >>>>>>> 6: (18) r8 =3D 0xffff88802735e000       ;
> >>>>>>> R8_w=3Dmap_ptr(off=3D0,ks=3D2396,vs=3D76,imm=3D0)
> >>>>>>> 8: (18) r9 =3D 0x8e9700000000           ; R9_w=3D156779191205888
> >>>>>>> 10: (36) if w9 >=3D 0xffffffe3 goto pc+1
> >>>>>>> last_idx 10 first_idx 0
> >>>>>>> regs=3D200 stack=3D0 before 8: (18) r9 =3D 0x8e9700000000
> >>>>>>> 11: R9_w=3D156779191205888
> >>>>>>> 11: (85) call #0
> >>>>>>> 12: (cc) w2 s>>=3D w7
> >>>>>
> >>>>> w2 should have been set to NOT_INIT (because r1-r5 are clobbered by
> >>>>> calls) and rejected here as !read_ok (see check_reg_arg()) before
> >>>>> attempting to mark precision for r2. Can you please try to debug an=
d
> >>>>> understand why that didn't happen here?
> >>>>
> >>>> The verifier is doing the right thing here and the 'call #0' does
> >>>> implicitly cleared r1-r5.
> >>>>
> >>>> So for 'w2 s>>=3D w7', since w2 is used, the verifier tries to find
> >>>> its definition by backtracing. It encountered 'call #0', which clear=
s
> >>>
> >>> and that's what I'm saying is incorrect. Normally we'd get !read_ok
> >>> error because s>>=3D is both READ and WRITE on w2, which is
> >>> uninitialized after call instruction according to BPF ABI. And that's
> >>> what actually seems to happen correctly in my (simpler) tests locally=
.
> >>> But something is special about this specific repro that somehow eithe=
r
> >>> bypasses this logic, or attempts to mark precision before we get to
> >>> that test. That's what we should investigate. I haven't tried to run
> >>> this specific repro locally yet, so can't tell for sure.
> >>>
> >>
> >> So, the reason why w2 is not marked as uninit is that the kfunc call i=
n
> >> the BPF program is invalid, "call #0", imm is zero, right?
> >
> > Yes, "call #0" is invalid. As the code below
> >
> >> /* skip for now, but return error when we find this in
> > fixup_kfunc_call */
> >>  if (!insn->imm)
> >>  return 0;
> >
> > The error report will be delayed later in fixup_kfunc_call().
> >
> > static int fixup_kfunc_call(struct bpf_verifier_env *env, struct
> > bpf_insn *insn,
> >                             struct bpf_insn *insn_buf, int insn_idx,
> > int *cnt)
> > {
> >         const struct bpf_kfunc_desc *desc;
> >
> >         if (!insn->imm) {
> >                 verbose(env, "invalid kernel function call not
> > eliminated in verifier pass\n");
> >                 return -EINVAL;
> >         }
> >
> >
> >> In check_kfunc_call(), it skips this error temporarily:
> >>
> >> /* skip for now, but return error when we find this in fixup_kfunc_cal=
l */
> >>  if (!insn->imm)
> >>  return 0;
> >>
> >> So the kfunc call is the previous instruction before "w2 s>>=3D w7", t=
his
> >> leads to the warning in backtrack_insn():
> >>
> >> /* regular helper call sets R0 */
> >> *reg_mask &=3D ~1;
> >> if (*reg_mask & 0x3f) {
> >>      /* if backtracing was looking for registers R1-R5
> >>      * they should have been found already.
> >>      */
> >>      verbose(env, "BUG regs %x\n", *reg_mask);
> >>      WARN_ONCE(1, "verifier backtracking bug=E2=80=9D);
> >>      return -EFAULT;
> >> }
> >
> > The main triggering the backtrack_insn() is due to
> >
> >                         } else {
> >                                 /* scalar +=3D pointer
> >                                  * This is legal, but we have to
> > reverse our
> >                                  * src/dest handling in computing the r=
ange
> >                                  */
> >                                 err =3D mark_chain_precision(env,
> > insn->dst_reg);
> >                                 if (err)
> >                                         return err;
> >                                 return adjust_ptr_min_max_vals(env, ins=
n,
> >                                                                src_reg,
> > dst_reg);
> >                         }
> >
> >
> > unc#0 @0
> > 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> > 0: (18) r2 =3D 0x8000000000000          ; R2_w=3D2251799813685248
> > 2: (18) r6 =3D 0xffff888100d29000       ;
> > R6_w=3Dmap_ptr(off=3D0,ks=3D3032,vs=3D3664,imm=3D0)
> > 4: (18) r7 =3D 0xffff888100d2a000       ;
> > R7_w=3Dmap_ptr(off=3D0,ks=3D156,vs=3D2624,imm=3D0)
> > 6: (18) r8 =3D 0xffff888100d2ac00       ;
> > R8_w=3Dmap_ptr(off=3D0,ks=3D2396,vs=3D76,imm=3D0)
> > 8: (18) r9 =3D 0x8e9700000000           ; R9_w=3D156779191205888
> > 10: (36) if w9 >=3D 0xffffffe3 goto pc+1
> > last_idx 10 first_idx 0
> > regs=3D200 stack=3D0 before 8: (18) r9 =3D 0x8e9700000000
> > 11: R9_w=3D156779191205888
> > 11: (85) call #0
> > 12: (cc) w2 s>>=3D w7
> > last_idx 12 first_idx 12
> > parent didn't have regs=3D4 stack=3D0 marks: R1=3Dctx(off=3D0,imm=3D0)
> > R2_rw=3DP2251799813685248 R6_w=3Dmap_ptr(off=3D0,ks=3D3032,vs=3D3664,im=
m=3D0)
> > R7_rw=3Dmap_ptr(off=3D0,ks=3D156,vs=3D2624,imm=3D0) R8_w=3Dmap_ptr(off=
=3D0,ks=3D2396,v0
> > last_idx 11 first_idx 0
> > regs=3D4 stack=3D0 before 11: (85) call #0
> > BUG regs 4
> >
> > For insn 12, 'w2 s>>=3D w7', w2 is a scalar and w7 is a map_ptr. Hence,
> > based on the above verifier code, mark_chain_precision() is triggered.
> >
> > Not sure what is the purpose of this test. But to make it succeed,
> > first "call #0" need to change to a valid kfunc call, and second, you
> > might want to change 'w2 s>>=3D w7' to e.g., 'w9 s>>=3D w7' to avoid
> > precision tracking.
> >
>
> The purpose is not to make the test "succeed", the verifier temporarily
> skips the invalid kfunc insn "call #0", but this insn triggered a warning
> in backtrack_insn(), while it is supposed to reject the program either
> due to insn#12 32bit ptr alu or insn#11 invalid kfunc.
>
> Maybe something like the bellow, after applying the patch, the reproducer
> is rejected:
>
> func#0 @0
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 0: (18) r2 =3D 0x8000000000000          ; R2_w=3D2251799813685248
> 2: (18) r6 =3D 0xffff88817d563000       ; R6_w=3Dmap_ptr(off=3D0,ks=3D303=
2,vs=3D3664,imm=3D0)
> 4: (18) r7 =3D 0xffff888171ee9000       ; R7_w=3Dmap_ptr(off=3D0,ks=3D156=
,vs=3D2624,imm=3D0)
> 6: (18) r8 =3D 0xffff888171ee8000       ; R8_w=3Dmap_ptr(off=3D0,ks=3D239=
6,vs=3D76,imm=3D0)
> 8: (18) r9 =3D 0x8e9700000000           ; R9_w=3D156779191205888
> 10: (36) if w9 >=3D 0xffffffe3 goto pc+1
> last_idx 10 first_idx 0
> regs=3D200 stack=3D0 before 8: (18) r9 =3D 0x8e9700000000
> 11: R9_w=3D156779191205888
> 11: (85) call #0
> 12: (cc) w2 s>>=3D w7
> last_idx 12 first_idx 12
> parent didn't have regs=3D4 stack=3D0 marks: R1=3Dctx(off=3D0,imm=3D0) R2=
_rw=3DP2251799813685248 R6_w=3Dmap_ptr(off=3D0,ks=3D3032,vs=3D3664,imm=3D0)=
 R7_rw=3Dmap_ptr(off=3D0,ks=3D156,vs=3D2624,imm=3D0) R8_w=3Dmap_ptr(off=3D0=
,ks=3D2396,vs=3D76,imm=3D0) R9_w=3D156779191205888 R10=3Dfp0
> last_idx 11 first_idx 0
> regs=3D4 stack=3D0 before 11: (85) call #0
> regs=3D4 stack=3D0 before 10: (36) if w9 >=3D 0xffffffe3 goto pc+1
> regs=3D4 stack=3D0 before 8: (18) r9 =3D 0x8e9700000000
> regs=3D4 stack=3D0 before 6: (18) r8 =3D 0xffff888171ee8000
> regs=3D4 stack=3D0 before 4: (18) r7 =3D 0xffff888171ee9000
> regs=3D4 stack=3D0 before 2: (18) r6 =3D 0xffff88817d563000
> regs=3D4 stack=3D0 before 0: (18) r2 =3D 0x8000000000000
> R2 32-bit pointer arithmetic prohibited
> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1 pe=
ak_states 1 mark_read 1
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4a25375ebb0d..abc7e96d826f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2743,6 +2743,9 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx,
>                         *reg_mask |=3D sreg;
>         } else if (class =3D=3D BPF_JMP || class =3D=3D BPF_JMP32) {
>                 if (opcode =3D=3D BPF_CALL) {
> +                       /* skip for now, should return error when we find=
 this in fixup_kfunc_call */
> +                       if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&=
 insn->imm =3D=3D 0)
> +                               return 0;


Makes sense to me. Please submit as an official patch
with s/return 0/return -ENOTSUPP/
Also 'skip for now' isn't quite correct here.
In check_kfunc_call() it's correct, since invalid kfunc with imm=3D=3D0
could be eliminated during dead code elimination,
but since we're walking this insn here in backtrack_insn
the dead code elimination is not going to kick in.
So it's surely invalid kfunc call if we see it in backtrack_insn.
The comment should probably be something like:
/* kfunc with imm=3D=3D0 is invalid and fixup_kfunc_call will catch
this error later. Make backtracking conservative with ENOTSUPP. */
