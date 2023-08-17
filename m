Return-Path: <bpf+bounces-7953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A977EF88
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 05:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F8281D86
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA1665D;
	Thu, 17 Aug 2023 03:31:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314D638
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 03:31:03 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759B62684
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 20:31:01 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cf2b1309so6035611fa.0
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692243060; x=1692847860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adfGQr440cHlWnyg1M6QnmDYpb15l+kv3s76raAD2eY=;
        b=Fe/2KylRHwsT7H/Pbu1Q/8UM/ssSiBWNrT4nWblPvvPSSFqSVk3w4ryX0PkueTr4P+
         aQtlXbnLUV7yDidHf0cA4YI+xMn4CwGn0mRh8ELqqPSAt+HBRqaUdpnCleRwh3e+E+Wy
         34j/Jl0S7EUuRZMWXv6BWKc293UsDhUdAuQLpJVtzRbdG8Th2bNedK48KDBRtYEdwPaM
         XVa13HFlvWDbY8rkk75nSmMEBlyrQdvMEX58CbxMJ+27HX6btuFFif7obGqdm/VdMkXq
         sgturXAcCV2n4V0+pMlk3JcpCpPONKbGmc1ekkjcBuqBZLBAKpj9fIibYn8oTwuH/6n9
         +8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692243060; x=1692847860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adfGQr440cHlWnyg1M6QnmDYpb15l+kv3s76raAD2eY=;
        b=JzYcBzSeO426627RliAP4JIRVRu2P7flS7etfOmGxxcmdE0WQweupVV4Uf/othFU10
         D/Kfdt574ZDS+8sRQoxnuYz/l40we8tbeokMudaGJJtWcpTT3pNjOPmPR2LDDNl8MKYI
         TKvIdfEtEBGz2KFU46uzBA5dDr0juRiHVkxTHSVuejmNcoT09IgSDKnSUpBmmBpO85jP
         D6fGz59YaGyVxs4Uaoj3kFHfPfO51okTn1aK0hzKsTNtPWe/0EWpm5hlmy4C/xwR+5Kk
         aJmu0+G27oszVWqCexjwu9LpYI+HEgAXS0me/GhMgBPZ9VeCw3e/o/DsDC2CBnHMHhf9
         8/bA==
X-Gm-Message-State: AOJu0Yz9bxjkVJOxYgqvrwuncbBwb4SPtcA99pl7Zf7BScBOOjal1aLz
	632ilMVU1ZckCrhnWcO4sS4KIdqGCoVmUPDrBP0=
X-Google-Smtp-Source: AGHT+IGt3Q5mTxsXVVVOIGwHevoqvAkzCtcNqasG3Jllg3jxFnsBHM+5GyPfPWxprCY4TZSFaJuxL//GWYAVjfOZXBw=
X-Received: by 2002:a2e:a37c:0:b0:2b6:9f95:8118 with SMTP id
 i28-20020a2ea37c000000b002b69f958118mr515284ljn.7.1692243059410; Wed, 16 Aug
 2023 20:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com> <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
In-Reply-To: <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Aug 2023 20:30:48 -0700
Message-ID: <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 16, 2023 at 7:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Aug 17, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Aug 14, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@=
linux.dev> wrote:
> > > >
> > > >
> > > >
> > > > On 8/14/23 7:33 AM, Yafang Shao wrote:
> > > > > Add a new bpf_current_capable kfunc to check whether the current =
task
> > > > > has a specific capability. In our use case, we will use it in a l=
sm bpf
> > > > > program to help identify if the user operation is permitted.
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > > >   kernel/bpf/helpers.c | 6 ++++++
> > > > >   1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index eb91cae..bbee7ea 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> > > > >       rcu_read_unlock();
> > > > >   }
> > > > >
> > > > > +__bpf_kfunc bool bpf_current_capable(int cap)
> > > > > +{
> > > > > +     return has_capability(current, cap);
> > > > > +}
> > > >
> > > > Since you are testing against 'current' capabilities, I assume
> > > > that the context should be process. Otherwise, you are testing
> > > > against random task which does not make much sense.
> > >
> > > It is in the process context.
> > >
> > > >
> > > > Since you are testing against 'current' cap, and if the capability
> > > > for that task is stable, you do not need this kfunc.
> > > > You can test cap in user space and pass it into the bpf program.
> > > >
> > > > But if the cap for your process may change in the middle of
> > > > run, then you indeed need bpf prog to test capability in real time.
> > > > Is this your use case and could you describe in in more detail?
> > >
> > > After we convert the capability of our networking bpf program from
> > > CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> > > encountered the "pointer comparison prohibited" error, because
> > > allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, if
> > > we enable the CAP_PERFMON for the networking bpf program, it can run
> > > tracing bpf prog, perf_event bpf prog and etc, that is not expected b=
y
> > > us.
> > >
> > > Hence we are planning to use a lsm bpf program to disallow it from
> > > running other bpf programs. In our lsm bpf program we will check the
> > > capability of processes, if the process has cap_net_admin, cap_bpf an=
d
> > > cap_perfmon but don't have cap_sys_admin we will refuse it to run
> > > tracing and perf_event bpf program. While if a process has  cap_bpf
> > > and cap_perfmon but doesn't have cap_net_admin, that said it is a bpf
> > > program which wants to run trace bpf, we will allow it.
> > >
> > > We can't use lsm_cgroup because it is supported on cgroup2 only, whil=
e
> > > we're still using cgroup1.
> > >
> > > Another possible solution is enable allow_ptr_leaks for cap_net_admin
> > > as well, but after I checked the commit which introduces the cap_bpf
> > > and cap_perfmon [1], I think we wouldn't like to do it.
> >
> > Sorry. None of these options are acceptable.
> >
> > The idea of introducing a bpf_current_capable() kfunc just to work
> > around a deficiency in the verifier is not sound.
>
> So what should we do then?
> Just enabling the cap_perfmon for it? That does not sound as well ...

Yonghong already pointed out upthread that
comparison of two packet pointers is not a pointer leak.
See this code:
        } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_r=
eg],
                                           this_branch, other_branch) &&
                   is_pointer_value(env, insn->dst_reg)) {
                verbose(env, "R%d pointer comparison prohibited\n",
                        insn->dst_reg);
                return -EACCES;
        }

It's not clear why it doesn't address your case.
That's what we should be discussing and debugging instead
of arguing about bpf_current_capable and similar "solutions".

> >
> > Next time instead of sending patch please describe the issue first.
> > You should have started with an email that:
> >         struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct e=
thhdr);
> >
> >         if ((long)(iph + 1) > (long)skb->data_end)
> > needs cap_perfmon.
>
> Got it.  Thanks for your explanation.
>
> --
> Regards
> Yafang

