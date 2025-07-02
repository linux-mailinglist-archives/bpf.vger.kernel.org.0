Return-Path: <bpf+bounces-62078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62661AF0D25
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D2A7A449B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 07:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41722F770;
	Wed,  2 Jul 2025 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="N9b9A3sa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1Jt68Gj"
X-Original-To: bpf@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564221CC40;
	Wed,  2 Jul 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442567; cv=none; b=UI7z/qr4tViCKi6els/PN7bWAFyPTOZvPKTo4J0FDOLHTk93uKImYxWdspLtRgIu6JsqsZsxvMSgqCu+/16RIGnnKb9efFY6ezr9sEKanbtkNaml/+p/uduVJlCW9Z1JaqOxgZxtwFQfTxRhmi1+PnWTDSbomTRwZR5tXzUalWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442567; c=relaxed/simple;
	bh=52fXD1UFrrI0w0OJzwAfiZpuVvJgiEwwkm0t/gGTz9g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fzhHdlfDJ0/3WpJSwxhsfMIH/XmAROpK17MKzWiu5t0caRQFH5gDAJaUjfhwez68qqMyzUW4oKsTR4q/ChRwpXjKYWxG62hvMuLgn1vUcet9FvaC5fNuAwV4DWSAbCkclyIpUyftHF6QRI7dCu7ff//+J4M+Re5TkRWOiRxCbAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=N9b9A3sa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1Jt68Gj; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id B727A13807E2;
	Wed,  2 Jul 2025 03:49:24 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 03:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751442564;
	 x=1751449764; bh=HkcGyddJZObF/m/oSGaP4HtMyuWT6VWhK/E9Vc1sQEA=; b=
	N9b9A3sa12p4jIYcTTtOiB0fJ0wsGKfy62Fl4dtENastHkJU2hG6fpsEiZ1iXD6z
	3yOpzNpOPgbxg+9dkbUBwId5jhgYaOsPll9SAH0D4QbacZK1RaI23/jsOHO8nWv4
	W85Pam5mQYto0e0gQMwHa+SONvFL6BuVpWGrF+9DJmXBklhfZ1nZjW/3j8H4vyTn
	DQw2QLd/FVDEUVbbqhDBDJN5ZvMUcZ6WzIZWdVZdNBe1PUpNJ6EDO7gmL99gvAIu
	mO0fiDVIQjRjaDITD+rE/t6bqiLFEa3IvhXhyh+KMIlVLAFWpWFKGigIfHRmY9QG
	5NkcvmbyDrtQGAYy+ZOHpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751442564; x=
	1751449764; bh=HkcGyddJZObF/m/oSGaP4HtMyuWT6VWhK/E9Vc1sQEA=; b=c
	1Jt68GjWbZML9JuLQCW/rQIte/lbDFEJSvoQjAkhJiSjrAwiXmEGUc15d2JhKukF
	IfHdp0sqY6Foenms5E3DsxjT0RKaC/qm4e5tq0L7j65tS5Sf1x0Ibqj/+noOvRR5
	vwpdBsAkqonqKTXpaoSfqF3LcSBMBthuDSoHiaPswScamr7ehS6rmH7NuDdty4FV
	xt62WnTczuVEass31JF1p4V+B/QV3lCisqBCidmlEBwjOUOQWmBGybv2cHCYVvxu
	vQROkSFunx6yAnGfaODZoiVylQRMnYN8bakl+bxfulCNwglFxfw5eb4yMKWiBDnp
	uJ7NBgpjwlq++wsXnEUHg==
X-ME-Sender: <xms:g-RkaMEa6MBwd3-fMG84Z5e7kKQUKa24E3d9ySmSZ_HhKvnc8E51aw>
    <xme:g-RkaFXmvvo_8-81itGSPqOuGtEbD9T0Psjpuk6oWosXoW0RLczm0ScCMwEYbbXKT
    1ecV5I6aOQ5j_M6xjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhuihhsrdhgvghrhhhorhhsthesfhgruhdruggvpdhrtghpthhtoh
    epshgufhesfhhomhhitghhvghvrdhmvgdprhgtphhtthhopegrlhgvgigvihdrshhtrghr
    ohhvohhithhovhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhhiihdrnhgrkh
    hrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtg
    homhdprhgtphhtthhopehmvghmgihorhesghhmrghilhdrtghomhdprhgtphhtthhopehn
    ihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpth
    htohephhgrohhluhhosehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:g-RkaGLI9En4NBd4kMWHd3HHk-TP_YierI-59FvM0cRU2bZ3z0H_wQ>
    <xmx:g-RkaOHJfGQNmXSQKSKMYu7EHbyYXBP8YuB34a6mLVN1fWtAXCwxVg>
    <xmx:g-RkaCXfMVxzKGDf4nvdJaybvEO2fBlKmiEB4Y6rj_xsa91TH7aDIA>
    <xmx:g-RkaBPduVywCegMlSMKk8cs5F43XViIGT4i_k5XfJ9hL9UUOSPehQ>
    <xmx:hORkaIAWG71JpAOr7VOS9talMxESppyu33eBp9_w2ZpQlK5QYwBGPSz->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B868E700065; Wed,  2 Jul 2025 03:49:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T78580a8332607909
Date: Wed, 02 Jul 2025 09:48:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yonghong Song" <yonghong.song@linux.dev>,
 "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Luis Gerhorst" <luis.gerhorst@fau.de>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>
Message-Id: <eb4b4473-c75e-4bfa-9a16-19a5256a558d@app.fastmail.com>
In-Reply-To: <646c1c27-b940-4ece-aa0f-dbeea8aa7de3@linux.dev>
References: <20250620113846.3950478-1-arnd@kernel.org>
 <CAADnVQKAT3UPzcpzkJ6_-powz4YTiDAku4-a+++hrhYdJUnLiw@mail.gmail.com>
 <361eb614-e145-49dc-aa32-12f313f61b96@linux.dev>
 <CAEf4BzahSLGiW_F4LtG1tMAb0O1b6D-kO0AcrU2O+nLKVbkvZA@mail.gmail.com>
 <646c1c27-b940-4ece-aa0f-dbeea8aa7de3@linux.dev>
Subject: Re: [PATCH] bpf: turn off sanitizer in do_misc_fixups for old clang
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025, at 23:28, Yonghong Song wrote:
> On 7/1/25 1:45 PM, Andrii Nakryiko wrote:
>> On Tue, Jul 1, 2025 at 1:03=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
>>> On 6/23/25 2:32 PM, Alexei Starovoitov wrote:
>>>> On Fri, Jun 20, 2025 at 4:38=E2=80=AFAM Arnd Bergmann <arnd@kernel.=
org> wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> I checked IR and found the following memory allocations which may co=
ntribute
>>> excessive stack usage:
>>>
>>> attr.coerce1, i32 noundef %uattr_size) local_unnamed_addr #0 align 1=
6 !dbg !19800 {
>>> entry:
>>>     %zext_patch.i =3D alloca [2 x %struct.bpf_insn], align 16, !DIAs=
signID !19854
>>>     %rnd_hi32_patch.i =3D alloca [4 x %struct.bpf_insn], align 16, !=
DIAssignID !19855
>>>     %cnt.i =3D alloca i32, align 4, !DIAssignID !19856
>>>     %patch.i766 =3D alloca [3 x %struct.bpf_insn], align 16, !DIAssi=
gnID !19857
>>>     %chk_and_sdiv.i =3D alloca [1 x %struct.bpf_insn], align 4, !DIA=
ssignID !19858
>>>     %chk_and_smod.i =3D alloca [1 x %struct.bpf_insn], align 4, !DIA=
ssignID !19859
>>>     %chk_and_div.i =3D alloca [4 x %struct.bpf_insn], align 16, !DIA=
ssignID !19860
>>>     %chk_and_mod.i =3D alloca [4 x %struct.bpf_insn], align 16, !DIA=
ssignID !19861
>>>     %chk_and_sdiv343.i =3D alloca [8 x %struct.bpf_insn], align 16, =
!DIAssignID !19862
>>>     %chk_and_smod472.i =3D alloca [9 x %struct.bpf_insn], align 16, =
!DIAssignID !19863
>>>     %desc.i =3D alloca %struct.bpf_jit_poke_descriptor, align 8, !DI=
AssignID !19864
>>>     %target_size.i =3D alloca i32, align 4, !DIAssignID !19865
>>>     %patch.i =3D alloca [2 x %struct.bpf_insn], align 16, !DIAssignI=
D !19866
>>>     %patch355.i =3D alloca [2 x %struct.bpf_insn], align 16, !DIAssi=
gnID !19867
>>>     %ja.i =3D alloca %struct.bpf_insn, align 8, !DIAssignID !19868
>>>     %ret_insn.i.i =3D alloca [8 x i32], align 16, !DIAssignID !19869
>>>     %ret_prog.i.i =3D alloca [8 x i32], align 16, !DIAssignID !19870
>>>     %fd.i =3D alloca i32, align 4, !DIAssignID !19871
>>>     %log_true_size =3D alloca i32, align 4, !DIAssignID !19872
>>> ...
>>>
>>> So yes, chk_and_{div,mod,sdiv,smod} consumes quite some stack and
>>> can be coverted to runtime allocation but that is not enough for 1280
>>> stack limit, we need to do more conversion from stack to memory
>>> allocation. Will try to have uniform way to convert
>>> 'alloca [<num> x %struct.bpf_insn]' to runtime allocation.
>>>
>> Do we need to go all the way to dynamic allocation? See env->insns_buf
>> (which some parts of this function are already using for constructing
>> instruction patch), let's just converge on that? It pre-allocates
>> space for 32 instructions, should be sufficient for all the use cases,
>> no?
>
> Make sense. This is much better. Thanks!

I'm not sure if that actually helps on the old clang version, as far
as I understood it in my initial analysis, the problem in the

struct bpf_insn chk_and_sdiv[] =3D {
                                /* [R,W]x sdiv 0 -> 0
                                 * LLONG_MIN sdiv -1 -> LLONG_MIN
                                 * INT_MIN sdiv -1 -> INT_MIN
                                 */
                                BPF_MOV64_REG(BPF_REG_AX, insn->src_reg),
...
}

construct is not the chk_and_sdiv[] array itself but the
struct initializer in the BPF_MOV64_REG() macro that leads to
having two copies of the struct on the stack and then copying
between them. In gcc or clang-18+, these all get folded
into a single object on the stack.

(Disclaimer: I don't understand anything about how clang
actually works internally, the above is only speculation on
my side, based on the assembler output)

      Arnd

