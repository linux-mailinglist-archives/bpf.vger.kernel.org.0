Return-Path: <bpf+bounces-73338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDD5C2B6A1
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 12:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3F53B9AD2
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A2A304BD4;
	Mon,  3 Nov 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWm599um"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB774303A04
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169397; cv=none; b=klPDf4moL0cP6JomGjUcgADScIn0Hf0Il7KmGO/ZxntJk1vpnzaFDtJIJz3k0QbUQQg3LPIN8xeGftCrd0g5SugpRhHTEmrtraxVztSpe1cPreDcx+txeR6ie39xx6hyaZ1p4D9z/1wAUl7Qrk8t5L+pFLDCc1dJw4pAdMiIrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169397; c=relaxed/simple;
	bh=02Xm9aWU5ML4s0PYpl8iCFqzRN8TlwzC37mlWleAjrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDIeK26oQ5KKwiOMOFTmBvMs4nIYJpSN3/91X1CRAax5ZIULhJ0LNEf6BFz9MJYBvgnpR94aH+WCgPdVx8SXApshgAeSVBoGGa46PZGPVs83RQ63ynZVusgA8pwoXSSM+XbZi+CPKQWRrMVX86IhXJZARavjbVszKjSNHXwYyvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWm599um; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762169382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2xZ0GILbr2Y9bhSsbkAZ2CEPTxZiSfugV1/vX9rVKA=;
	b=cWm599um4HMWXTwV1n8vvwWPvQqMP+7/3CHcMzLdrMiM8M0FsJUS2NuJ8f7jmc68b6+eu2
	/LuxjLHgpDMBxj7NnOOdBfvDcCcMg+3/NljupUr9RL6/3PHkp3iM+u2CcUQgj7xa/zxxL0
	giOHD3IAQ48Q6+0rEE6mJsAE/9jg6LE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting for
 x86_64
Date: Mon, 03 Nov 2025 19:24:24 +0800
Message-ID: <3577705.QJadu78ljV@7950hx>
In-Reply-To:
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
References:
 <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
 <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/1 01:57, Alexei Starovoitov wrote:
> On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> > > >
> > > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entr=
y and
> > > > invoke_bpf_session_exit is introduced for this purpose.
> > > >
> > > > In invoke_bpf_session_entry(), we will check if the return value of=
 the
> > > > fentry is 0, and set the corresponding session flag if not. And in
> > > > invoke_bpf_session_exit(), we will check if the corresponding flag =
is
> > > > set. If set, the fexit will be skipped.
> > > >
> > > > As designed, the session flags and session cookie address is stored=
 after
> > > > the return value, and the stack look like this:
> > > >
> > > >   cookie ptr    -> 8 bytes
> > > >   session flags -> 8 bytes
> > > >   return value  -> 8 bytes
> > > >   argN          -> 8 bytes
> > > >   ...
> > > >   arg1          -> 8 bytes
> > > >   nr_args       -> 8 bytes
> > > >   ...
> > > >   cookieN       -> 8 bytes
> > > >   cookie1       -> 8 bytes
> > > >
> > > > In the entry of the session, we will clear the return value, so the=
 fentry
> > > > will always get 0 with ctx[nr_args] or bpf_get_func_ret().
> > > >
> > > > Before the execution of the BPF prog, the "cookie ptr" will be fill=
ed with
> > > > the corresponding cookie address, which is done in
> > > > invoke_bpf_session_entry() and invoke_bpf_session_exit().
> > >
> > > ...
> > >
> > > > +       if (session->nr_links) {
> > > > +               for (i =3D 0; i < session->nr_links; i++) {
> > > > +                       if (session->links[i]->link.prog->call_sess=
ion_cookie)
> > > > +                               stack_size +=3D 8;
> > > > +               }
> > > > +       }
> > > > +       cookies_off =3D stack_size;
> > >
> > > This is not great. It's all root and such,
> > > but if somebody attaches 64 progs that use session cookies
> > > then the trampoline will consume 64*8 of stack space just for
> > > these cookies. Plus more for args, cookie, ptr, session_flag, etc.
> >
> > The session cookie stuff does take a lot of stack memory.
> > For fprobe, it will store the cookie into its shadow stack, which
> > can free the stack.
> >
> > How about we remove the session cookie stuff? Therefore,
> > only 8-bytes(session flags) are used on the stack. And if we reuse
> > the nr_regs slot, no stack will be consumed. However, it will make
> > thing complex, which I don't think we should do.
> >
> > > Sigh.
> > > I understand that cookie from one session shouldn't interfere
> > > with another, but it's all getting quite complex
> > > especially when everything is in assembly.
> > > And this is just x86 JIT. Other JITs would need to copy
> > > this complex logic :(
> >
> > Without the session cookie, it will be much easier to implement
> > in another arch. And with the hepler of AI(such as cursor), it can
> > be done easily ;)
>=20
> The reality is the opposite. We see plenty of AI generated garbage.
> Please stay human.

It's not wised to make the AI generate all the things for us, and
I find the AI is not good at planing and designing, but good at
implement a single thing, such as generating a instruction or
machine code from the C code. Of course I can generate it by
myself with clang, but it still save a lot efforts.

>=20
> >
> > > At this point I'm not sure that "symmetry with kprobe_multi_session"
> > > is justified as a reason to add all that.
> > > We don't have a kprobe_session for individual kprobes after all.
> >
> > As for my case, the tracing session can make my code much
> > simpler, as I always use the fentry+fexit to hook a function. And
> > the fexit skipping according to the return value of fentry can also
> > achieve better performance.
>=20
> I don't buy the argument that 'if (cond) goto skip_fexit_prog'
> in the generated trampoline is measurably faster than
> 'if (cond) return' inside the fexit program.

=46or now, there maybe no performance improvement. And I
were playing to implement such logic in the next step:

If there are no fexit and modify_return progs in the trampoline,
I'll check if "session_flags =3D=3D ALL_SKIP" after the entry of the
fsession, and skip the origin call in such case and return directly
in such case. Therefore, the performance of fsession is almost
the same as fentry. According to our testing, the performance
of fexit is half of fentry. So the performance in this case has a
100% increasing.

This is a just rough thought, not sure if it works.

In fact, the performance improvement can be achieved more in the
bpf prog. For example, I want to trace the return value of skb_clone()
with the TCP port being 8080, I have to write following code:

SEC("fentry/skb_clone")
int clone_entry(struct sk_buff *skb)
{
    /* parse the skb and do some filter
     *    |
     * return 0 if not TCP + 80 port
     *    |
     * save the address of "skb" to the hash table "m_context"
     *    |
     * output the skb + timestamp
     */
    return 0;
}

SEC("fexit/skb_clone")
int clone_exit(struct sk_buff *skb, u64 ret)
{
    /* lookup if skb in the "m_context", return 0 if not
     *    |
     * output the skb + return value + timestamp
     *    |
     * delete the "skb" from the m_context
     */
    return 0;
}

I have to maintain a hash table "m_context" to check if
the exit of skb_clone() is what I want. It works, but it has
extra overhead in the hash table lookup and deleting. What's
more, it's not stable on some complex case.

The problem is that we don't has a way to pair the
fentry/fexit on the stack(do we?).

>=20
> > AFAIT, the mast usage of session cookie in kprobe is passing the
> > function arguments to the exit. For tracing, we can get the args
> > in the fexit. So the session cookie in tracing is not as important as
> > in kprobe.
>=20
> Since kprobe_multi was introduced, retsnoop and tetragon adopted
> it to do mass attach, and both use bpf_get_attach_cookie().
> While both don't use bpf_session_cookie().
> Searching things around I also didn't find a single real user
> of bpf_session_cookie() other than selftests/bpf and Jiri's slides :)
>=20
> So, doing all this work in trampoline for bpf_session_cookie()
> doesn't seem warranted, but with that doing session in trampoline
> also doesn't look useful, since the only benefit vs a pair
> of fentry/fexit is skip of fexit, which can be done already.
> Plus complexity in all JITs... so, I say, let's shelve the whole thing fo=
r now.

Yeah, the session cookie is not useful in my case too, I'm OK to
skip it.

The pair of fentry/fexit have some use cases(my nettrace and
Leon's bpfsnoop, at least). Not sure if the reason above is sufficient,
please ignore the message if it is not :)

The way we implement the trampoline makes it arch related and
complex. I tried to rewrite it with C code, but failed. It's too difficult
and I suspect it's impossible :/

Thanks!
Menglong Dong

>=20
>=20





