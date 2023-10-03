Return-Path: <bpf+bounces-11240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8127B5EE0
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 26388B20982
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 02:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F10A7ED;
	Tue,  3 Oct 2023 02:01:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8163D
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 02:00:57 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636C19B
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 19:00:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3248e90f032so467569f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Oct 2023 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696298454; x=1696903254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wrppxv2shva8PQdxhEBsJZpU9STSdphR04M1qS7hpbA=;
        b=a6wjoCR3AAX9BVFtha6+L+W3++1Xv2/IhutCcCNuDnW7oOS+N/FvIdWO6xBBYThkuu
         j4c1NYHAggsImezwKm9ijV55TJe2GCqoN1o/45ZJiqmNvWU+cCAuYRRQnad+xcwzKE5Q
         YiuzJPDSgFtwp3tLl8B17xKcoIIBsUfQxn0LeDIaHO1+3dl1oJJ7JSwM/P+CCcuZuO43
         2TQiSDhf7I+OYNWwHte3u2BOPOBQBbILQqYhjt6+6+FBTJ1udkJ9kPX6CTkir4TedQC6
         4MvWfCF7scWJXbKmrYt5CQbZGnOli22cjnjBnLAozWZ8OYOZ5BnVSGZarCRjBobm5a7I
         106Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696298454; x=1696903254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrppxv2shva8PQdxhEBsJZpU9STSdphR04M1qS7hpbA=;
        b=ge84n8TtvnWyOGM8/qsXtFsrWjIQeiest9jr27e62IpHx8uqkbktRYM0IXhmr1lcVN
         4q6sDFqZsbeUSvRg5114Nf3gJIxUbgfsfpgXfDKFCXPF82ldAwWa2Mb8Oe+dn5x8Xsnj
         p2lswpnH/lF3Zj4xpdhWEI3/68ZGf3JeI7ifbPgccVtX+srhSKoVCGjFGcE0nzBg1SbX
         ZddotoiUJayrR9xERNu0QZ0XkMc3fIywPvwceWb5nXzm1I2g8Hlf0oDtnw05/3jmA4O4
         TRJ//7Bi9soWHgwy8rEJbJiB7zJqelpcJhuSsJpvY8HjN+66bqkbCYaTQyRyiaLReFJV
         D9WQ==
X-Gm-Message-State: AOJu0YwcXeohb8NlD0KY2Ujv9/N3hVSf8nBDXDlKIUvksNYPNNvxoHQK
	G8xU6oMifcM/ky7BHdEc130RzYUakNJ2hpkveEG/4BO0Z2E=
X-Google-Smtp-Source: AGHT+IFVSQEqIytU4gyVLI9ma7ADxi9mzO/ucHt3ZGs+uO3djFm64jpJutOanI1+zuCq0Pvtl0G5Zs10cMyx26vDZJc=
X-Received: by 2002:a5d:65c5:0:b0:317:6175:95fd with SMTP id
 e5-20020a5d65c5000000b00317617595fdmr11800794wrw.43.1696298453512; Mon, 02
 Oct 2023 19:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+vRuzPChFNXmouzGG+wsy=6eMcfr1mFG0F3g7rbg-sedGKW3w@mail.gmail.com>
 <CAADnVQJpLAzmUfwvWBr8a_PWHYHxHw9vdAXnWB4R4PbVY4S4mw@mail.gmail.com>
 <CAEf4Bzbubu7KjBv=98BZrVnTrcfPQrnsp-g1kOYKM=kUtiqEgw@mail.gmail.com>
 <dff1cfec20d1711cb023be38dfe886bac8aac5f6.camel@gmail.com>
 <CAP01T76duVGmnb+LQjhdKneVYs1q=ehU4yzTLmgZdG0r2ErOYQ@mail.gmail.com>
 <a2995c1d7c01794ca9b652cdea7917cac5d98a16.camel@gmail.com>
 <97a90da09404c65c8e810cf83c94ac703705dc0e.camel@gmail.com>
 <CAEf4BzYg8T_Dek6T9HYjHZCuLTQT8ptAkQRxrsgaXg7-MZmHDA@mail.gmail.com>
 <ee714151d7c840c82d79f9d12a0f51ef13b798e3.camel@gmail.com>
 <CAADnVQJn35f0UvYJ9gyFT4BfViXn8T8rPCXRAC=m_Jx_CFjrtw@mail.gmail.com>
 <5649df64315467c67b969e145afda8bbf7e60445.camel@gmail.com>
 <CAADnVQJO0aVJfV=8RDf5rdtjOCC-=57dmHF20fQYV9EiW2pJ2Q@mail.gmail.com>
 <4b121c3b96dcc0322ea111062ed2260d2d1d0ed7.camel@gmail.com>
 <CAEf4BzbUxHCLhMoPOtCC=6Y-OxkkC9GvjykC8KyKPrFxp6cLvw@mail.gmail.com>
 <52df1240415be1ee8827cb6395fd339a720e229c.camel@gmail.com>
 <ec118c24a33fb740ecaafd9a55416d56fcb77776.camel@gmail.com>
 <CAEf4BzZjut_JGnrqgPE0poJhMjJgtJcafRd6Z_0T0jrW3zARJw@mail.gmail.com>
 <44363f61c49bafa7901ae2aa43897b525805192c.camel@gmail.com>
 <CAEf4BzZ-NGiUVw+yCRCkrPQbJAS4wMBsT3e=eYVMuintqKDKqg@mail.gmail.com>
 <a777445dcb94c0029eb3bd3ddc96ddc493c85ad0.camel@gmail.com>
 <CAEf4BzZU0MxwLfz-dGbmHbEtqVhEMTxwSG+QfwCuCv09CqLcNw@mail.gmail.com>
 <ca9ac095cf1b3fff55eea8a3c87670a349bbfbcf.camel@gmail.com>
 <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com> <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
In-Reply-To: <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Oct 2023 19:00:41 -0700
Message-ID: <CAADnVQJ3=x8hfv7d29FQ-ckzh9=MXo54cnFShFp=eG0fJjdDow@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c14e1e0606c642a2"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000c14e1e0606c642a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 2, 2023 at 5:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 2, 2023 at 10:18=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Mon, 2023-10-02 at 09:29 -0700, Alexei Starovoitov wrote:
> > [...]
> > > > I'd like to argue about B "widening" for a bit, as I think it might=
 be
> > > > interesting in general, and put A aside for now. The algorithm for
> > > > widening looks as follows:
> > > > - In is_states_equal() for (sl->state.branches > 0 && is_iter_next_=
insn()) case:
> > > >   - Check if states are equal exactly:
> > > >     - ignore liveness marks on old state;
> > > >     - demand same type for registers and stack slots;
> > > >     - ignore precision marks, instead compare scalars using
> > > >       regs_exact() [this differs from my previous emails, I'm now s=
ure
> > > >       that for this scheme to be correct regs_exact() is needed].
> > > >   - If there is an exact match then follow "hit" branch. The idea
> > > >     being that visiting exactly the same state can't produce new
> > > >     execution paths (like with graph traversal).
> > >
> > > Right. Exactly the same C state won't produce new paths
> > > as seen in visited state V, but
> > > if C=3D=3DV at the same insn indx it means we're in the infinite loop=
.
> >
> > This is true in general, but for bpf_iter_next() we have a guarantee
> > that iteration would end eventually.
> >
> > > > More formally, before pruning potential looping states we need to
> > > > make sure that all precision and read marks are in place.
> > > > To achieve this:
> > > > - Process states from env->head while those are available, in case =
if
> > > >   potential looping state (is_states_equal()) is reached put it to =
a
> > > >   separate queue.
> > > > - Once all env->head states are processed the only source for new r=
ead
> > > >   and precision marks is in postponed looping states, some of which
> > > >   might not be is_states_equal() anymore. Submit each such state fo=
r
> > > >   verification until fixed point is reached (repeating steps for
> > > >   env->head processing).
> > >
> > > Comparing if (sl->state.branches) makes sense to find infinite loop.
> > > It's waste for the verifier to consider visited state V with branches=
 > 0
> > > for pruning.
> > > The safety of V is unknown. The lack of liveness and precision
> > > is just one part. The verifier didn't conclude that V is safe yet.
> > > The current state C being equivalent to V doesn't tell us anything.
> > >
> > > If infinite loop detection logic trips us, let's disable it.
> > > I feel the fix should be in process_iter_next_call() to somehow
> > > make it stop doing push_stack() when states_equal(N-1, N-2).
> >
> > Consider that we get to the environment state where:
> > - all env->head states are exhausted;
> > - all potentially looping states (stored in as a separate set of
> >   states instead of env->head) are states_equal() to some already
> >   explored state.
> >
> > I argue that if such environment state is reached the program should
> > be safe, because:
> > - Each looping state L is a sub-state of some explored state V and
> >   every path from V leads to either safe exit or another loop.
> > - Iterator loops are guaranteed to exit eventually.
>
> It sounds correct, but I don't like that the new mechanism
> with two stacks of states completely changes the way the verifier works.
> The check you proposed:
> if (env->stack_size !=3D 0)
>       push_iter_stack()
> rings alarm bells.
>
> env->stack_size =3D=3D 0 (same as env->head exhausted) means we're done
> with verification (ignoring bpf_exit in callbacks and subprogs).
> So above check looks like a hack for something that I don't understand ye=
t.
> Also there could be branches in the code before and after iter loop.
> With "opportunistic" states_equal() for looping states and delayed
> reschedule_loop_states() to throw states back at the verifier
> the whole verification model is non comprehensible (at least to me).
> The stack + iter_stack + reschedule_loop_states means that in the followi=
ng:
> foo()
> {
>   br1 // some if() {...} block
>   loop {
>     br2
>   }
>   br3
> }
>
> the normal verifier pop_stack logic will check br3 and br1,
> but br2 may or may not be checked depending on "luck" of states_equal
> and looping states that will be in iter_stack.
> Then the verifier will restart from checking loop-ing states.
> If they somehow go past the end of the loop all kinds of things go crazy.
> update_branch_counts() might warn, propagate_liveness, propagate_precisio=
n
> will do nonsensical things.
> This out-of-order state processing distorts the existing model so
> much that I don't see how we can reason about these two stacks verificati=
on.
>
>
> I think the cleaner solution is to keep current single stack model.
> In the above example the verifier would reach the end, then check br3,
> then check br2,
> then we need to split branches counter somehow, so that we can
> compare loop iter states with previous visited states that are known
> to be safe.
> In visited states we explored everything in br3 and in br2,
> so no concerns that some path inside the loop or after the loop
> missed precision or liveness.
> Maybe we can split branches counter into branches due to 'if' blocks
> and branches due to process_iter_next_call().
> If there are pending process_iter_next_call-caused states it's still
> ok to call states_equal on such visited states.
>
> I could be missing something, of course.

Attached patch is what I meant.
It needs more work, but gives an idea.
simple iterators load fine and it correctly
detects unsafe code in num_iter_bug() example where you have
0xdeadbeef in R1.

--000000000000c14e1e0606c642a2
Content-Type: application/octet-stream; name="0001-iter-hack.patch"
Content-Disposition: attachment; filename="0001-iter-hack.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ln9nyudo0>
X-Attachment-Id: f_ln9nyudo0

RnJvbSBmMTk0Y2I1NDBjZDNhODdlM2Q3NDVhNDNjM2M4MmRiY2Q2MjlkNzY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBNb24sIDIgT2N0IDIwMjMgMTg6MzA6MjMgLTA3MDAKU3ViamVjdDogW1BBVENIXSBpdGVy
IGhhY2sKClNpZ25lZC1vZmYtYnk6IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+
Ci0tLQogaW5jbHVkZS9saW51eC9icGZfdmVyaWZpZXIuaCB8ICAyICsrCiBrZXJuZWwvYnBmL3Zl
cmlmaWVyLmMgICAgICAgIHwgMTMgKysrKysrKysrKy0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
YnBmX3ZlcmlmaWVyLmggYi9pbmNsdWRlL2xpbnV4L2JwZl92ZXJpZmllci5oCmluZGV4IDk0ZWM3
NjY0MzJmNS4uM2IyMTMxYzJkZGNkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2JwZl92ZXJp
Zmllci5oCisrKyBiL2luY2x1ZGUvbGludXgvYnBmX3ZlcmlmaWVyLmgKQEAgLTM2NywxMiArMzY3
LDE0IEBAIHN0cnVjdCBicGZfdmVyaWZpZXJfc3RhdGUgewogCSAqIEluIHN1Y2ggY2FzZXMgQlBG
X0NPTVBMRVhJVFlfTElNSVRfSU5TTlMgbGltaXQga2lja3MgaW4uCiAJICovCiAJdTMyIGJyYW5j
aGVzOworCXUzMiBsb29waW5nX3N0YXRlczsKIAl1MzIgaW5zbl9pZHg7CiAJdTMyIGN1cmZyYW1l
OwogCiAJc3RydWN0IGJwZl9hY3RpdmVfbG9jayBhY3RpdmVfbG9jazsKIAlib29sIHNwZWN1bGF0
aXZlOwogCWJvb2wgYWN0aXZlX3JjdV9sb2NrOworCWJvb2wgbG9vcGluZ19zdGF0ZTsKIAogCS8q
IGZpcnN0IGFuZCBsYXN0IGluc24gaWR4IG9mIHRoaXMgdmVyaWZpZXIgc3RhdGUgKi8KIAl1MzIg
Zmlyc3RfaW5zbl9pZHg7CmRpZmYgLS1naXQgYS9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMgYi9rZXJu
ZWwvYnBmL3ZlcmlmaWVyLmMKaW5kZXggZWVkNzM1MGUxNWY0Li43ZWY0MWMzNTc1NzUgMTAwNjQ0
Ci0tLSBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYworKysgYi9rZXJuZWwvYnBmL3ZlcmlmaWVyLmMK
QEAgLTE3NjIsNiArMTc2Miw4IEBAIHN0YXRpYyBpbnQgY29weV92ZXJpZmllcl9zdGF0ZShzdHJ1
Y3QgYnBmX3ZlcmlmaWVyX3N0YXRlICpkc3Rfc3RhdGUsCiAJZHN0X3N0YXRlLT5hY3RpdmVfbG9j
ay5wdHIgPSBzcmMtPmFjdGl2ZV9sb2NrLnB0cjsKIAlkc3Rfc3RhdGUtPmFjdGl2ZV9sb2NrLmlk
ID0gc3JjLT5hY3RpdmVfbG9jay5pZDsKIAlkc3Rfc3RhdGUtPmJyYW5jaGVzID0gc3JjLT5icmFu
Y2hlczsKKwlkc3Rfc3RhdGUtPmxvb3Bpbmdfc3RhdGVzID0gc3JjLT5sb29waW5nX3N0YXRlczsK
Kwlkc3Rfc3RhdGUtPmxvb3Bpbmdfc3RhdGUgPSBzcmMtPmxvb3Bpbmdfc3RhdGU7CiAJZHN0X3N0
YXRlLT5wYXJlbnQgPSBzcmMtPnBhcmVudDsKIAlkc3Rfc3RhdGUtPmZpcnN0X2luc25faWR4ID0g
c3JjLT5maXJzdF9pbnNuX2lkeDsKIAlkc3Rfc3RhdGUtPmxhc3RfaW5zbl9pZHggPSBzcmMtPmxh
c3RfaW5zbl9pZHg7CkBAIC0xNzg1LDYgKzE3ODcsOCBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfYnJh
bmNoX2NvdW50cyhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBzdHJ1Y3QgYnBmX3Zlcmlm
aQogCXdoaWxlIChzdCkgewogCQl1MzIgYnIgPSAtLXN0LT5icmFuY2hlczsKIAorCQlpZiAoc3Qt
Pmxvb3Bpbmdfc3RhdGUgJiYgc3QtPnBhcmVudCkKKwkJCXN0LT5wYXJlbnQtPmxvb3Bpbmdfc3Rh
dGVzLS07CiAJCS8qIFdBUk5fT04oYnIgPiAxKSB0ZWNobmljYWxseSBtYWtlcyBzZW5zZSBoZXJl
LAogCQkgKiBidXQgc2VlIGNvbW1lbnQgaW4gcHVzaF9zdGFjaygpLCBoZW5jZToKIAkJICovCkBA
IC0xODQ3LDYgKzE4NTEsNyBAQCBzdGF0aWMgc3RydWN0IGJwZl92ZXJpZmllcl9zdGF0ZSAqcHVz
aF9zdGFjayhzdHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LAogCWVyciA9IGNvcHlfdmVyaWZp
ZXJfc3RhdGUoJmVsZW0tPnN0LCBjdXIpOwogCWlmIChlcnIpCiAJCWdvdG8gZXJyOworCWVsZW0t
PnN0Lmxvb3Bpbmdfc3RhdGUgPSBmYWxzZTsKIAllbGVtLT5zdC5zcGVjdWxhdGl2ZSB8PSBzcGVj
dWxhdGl2ZTsKIAlpZiAoZW52LT5zdGFja19zaXplID4gQlBGX0NPTVBMRVhJVFlfTElNSVRfSk1Q
X1NFUSkgewogCQl2ZXJib3NlKGVudiwgIlRoZSBzZXF1ZW5jZSBvZiAlZCBqdW1wcyBpcyB0b28g
Y29tcGxleC5cbiIsCkBAIC03NzMzLDcgKzc3MzgsOSBAQCBzdGF0aWMgaW50IHByb2Nlc3NfaXRl
cl9uZXh0X2NhbGwoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4LAog
CQlxdWV1ZWRfc3QgPSBwdXNoX3N0YWNrKGVudiwgaW5zbl9pZHggKyAxLCBpbnNuX2lkeCwgZmFs
c2UpOwogCQlpZiAoIXF1ZXVlZF9zdCkKIAkJCXJldHVybiAtRU5PTUVNOwotCisJICAgICAgICBp
ZiAocXVldWVkX3N0LT5wYXJlbnQpCisJICAgICAgICAgICAgICAgIHF1ZXVlZF9zdC0+cGFyZW50
LT5sb29waW5nX3N0YXRlcysrOworCQlxdWV1ZWRfc3QtPmxvb3Bpbmdfc3RhdGUgPSB0cnVlOwog
CQlxdWV1ZWRfaXRlciA9ICZxdWV1ZWRfc3QtPmZyYW1lW2l0ZXJfZnJhbWVub10tPnN0YWNrW2l0
ZXJfc3BpXS5zcGlsbGVkX3B0cjsKIAkJcXVldWVkX2l0ZXItPml0ZXIuc3RhdGUgPSBCUEZfSVRF
Ul9TVEFURV9BQ1RJVkU7CiAJCXF1ZXVlZF9pdGVyLT5pdGVyLmRlcHRoKys7CkBAIC0xNjQ1MSw3
ICsxNjQ1OCw3IEBAIHN0YXRpYyBpbnQgaXNfc3RhdGVfdmlzaXRlZChzdHJ1Y3QgYnBmX3Zlcmlm
aWVyX2VudiAqZW52LCBpbnQgaW5zbl9pZHgpCiAJCWlmIChzbC0+c3RhdGUuaW5zbl9pZHggIT0g
aW5zbl9pZHgpCiAJCQlnb3RvIG5leHQ7CiAKLQkJaWYgKHNsLT5zdGF0ZS5icmFuY2hlcykgewor
CQlpZiAoc2wtPnN0YXRlLmJyYW5jaGVzICYmIHNsLT5zdGF0ZS5icmFuY2hlcyAhPSBzbC0+c3Rh
dGUubG9vcGluZ19zdGF0ZXMpIHsKIAkJCXN0cnVjdCBicGZfZnVuY19zdGF0ZSAqZnJhbWUgPSBz
bC0+c3RhdGUuZnJhbWVbc2wtPnN0YXRlLmN1cmZyYW1lXTsKIAogCQkJaWYgKGZyYW1lLT5pbl9h
c3luY19jYWxsYmFja19mbiAmJgpAQCAtMTY0ODEsNyArMTY0ODgsNyBAQCBzdGF0aWMgaW50IGlz
X3N0YXRlX3Zpc2l0ZWQoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgaW50IGluc25faWR4
KQogCQkJICogYWNjb3VudCBpdGVyX25leHQoKSBjb250cmFjdCBvZiBldmVudHVhbGx5IHJldHVy
bmluZwogCQkJICogc3RpY2t5IE5VTEwgcmVzdWx0LgogCQkJICovCi0JCQlpZiAoaXNfaXRlcl9u
ZXh0X2luc24oZW52LCBpbnNuX2lkeCkpIHsKKwkJCWlmICgwICYmIGlzX2l0ZXJfbmV4dF9pbnNu
KGVudiwgaW5zbl9pZHgpKSB7CiAJCQkJaWYgKHN0YXRlc19lcXVhbChlbnYsICZzbC0+c3RhdGUs
IGN1cikpIHsKIAkJCQkJc3RydWN0IGJwZl9mdW5jX3N0YXRlICpjdXJfZnJhbWU7CiAJCQkJCXN0
cnVjdCBicGZfcmVnX3N0YXRlICppdGVyX3N0YXRlLCAqaXRlcl9yZWc7Ci0tIAoyLjM0LjEKCg==
--000000000000c14e1e0606c642a2--

