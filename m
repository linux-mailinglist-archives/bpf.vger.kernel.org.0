Return-Path: <bpf+bounces-31864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8862D904307
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1831F247B3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD36659162;
	Tue, 11 Jun 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kvXB5kpZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHrnGfVd"
X-Original-To: bpf@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481991CD06;
	Tue, 11 Jun 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128870; cv=none; b=VRIFj20N3pGIau7RblRiEKcGQqlyH8ogqBiPZ4NmbgDZYZgUrl9jmI3db8hzlvMoY62cma0AvIAby/OPbu9UmVH30pgADTK9pjn4gbqJ7HBRO6K5I/NNQwyVpk0HJM85KzsQZuWhH8Qt8n0GPT/bdhcg+6c7VvvwkTa487Wpi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128870; c=relaxed/simple;
	bh=8QWtb6pcKPnWcVLg2JzrAry10KmxCU8luPjLBJwvgjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsWr/8hIsmZgzXUu/LI/9ZymOOl6ioGzPIGhdQHKG5AEoThOqVCFrmCOLEnGp/10I5Jike+Iz+nBR6l29mzkeP9pGbQT10JrJjF5latqOh2zJ98lV/ZxGxNfkQSHfwlu6CPNcSbiXCTVvpsMoHbLmWx2B+/1OewJU6giACxyZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=kvXB5kpZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHrnGfVd; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 42EF61380087;
	Tue, 11 Jun 2024 14:01:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 14:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1718128867;
	 x=1718215267; bh=3TsTy4miANTIONNoIvT1RtaTHJWrsau+L4RJ3v/4SRY=; b=
	kvXB5kpZt5ftlNR+NOZR2zGB46PyiXp4NYl/4hlvTr4JkKAl7g/d9Gf/xaS09Sbd
	2q+bUizUBO+r9l31TNHh24BNa0tsKtsdKUfp3Q6TavlOb6bADTioee7wCt6rqzYI
	YuQ2wcErEU79wY1uNWM02UVeu7djV0XWLZBj5FzDco5kDjhdJGOzh8ZmJYhg4SSq
	uz+TRzWlmhMMQzYKclUcxd1lPCX+Y0kexOQlQnPJLgrr3j8nhCdA5/AD2BnnFQk8
	zYAoxIBCWHAJuaUUFP1TW8kK6RoLahxK1qw94NBXHY+cETka+0yoMoLW4mfgtGwn
	gbM+uKOoe/JGQkAyzmJ94g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718128867; x=
	1718215267; bh=3TsTy4miANTIONNoIvT1RtaTHJWrsau+L4RJ3v/4SRY=; b=k
	HrnGfVd8lxcs207atytWSbFMwCys3wj1s8VJDOV3q3dIIR5NXVlzVCTxBAk3dChc
	ZRYXcuhHLdAbHtTDq6zl8/vc2xQQtpBVEtezY+YWxvMXB4LG8KqWM6ycgj6tVXvq
	aeSqRIfqhQ2lKdMGrI5Fu+npXmi5bTilQeBUgUZZiIBrv+l67Tw4PNK6TIFwKvyy
	tCfKzGiKqkkv/+WDQoYlxP39desrRUeYIz0TTS98++pwdLf+2YafR8K/028YWVm0
	iCAZX9FJW0N9Qga+LC6Y2ibhSSA1ZvPgnntcjDCnrvaGjLGr4GJY0T+ocSh8y5ze
	5eoSXL5G4Ym16cYYwCMiQ==
X-ME-Sender: <xms:4pBoZiQemXit2yGSgoxA5qfe4hfknYfWVNNlNBwIHgM8C-bCOFyqdQ>
    <xme:4pBoZnxJbDPJXwC7E4AxTPcVaI6A8PyhC9sdd-IWw60P_iMh7_zlAXvFCNdhILjr5
    qWwy_Di35h96jvOcg>
X-ME-Received: <xmr:4pBoZv0J0Wz-o6WhYtx-DicycDXrufNgjihD-yiV7lWUQx7pR8a5UPhKX2rvTv4ELshDjlXaHFf28_wOwXOaUmMjumv61BSkeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:4pBoZuD6GQSymjTm-MhH1MPoFT8r6tpqgneQkK1MOP7Ye29r1P7JuA>
    <xmx:4pBoZrjVONmYdkVuh-Hi7DIFIxuAk2qntLK1vNEL8AFASZaVnxo4GA>
    <xmx:4pBoZqrrvKOtx_HUWdw0J2-A4QjTUbMLq2_hCJ8gqhyFvZGJT_ODCA>
    <xmx:4pBoZuikgJI4WNQewUCATbQkt2wtYgP-zCpDNMSYLZo1z1TSiSLDWA>
    <xmx:45BoZuik6MDwrig-XTVp9PE013217hcG7qyUastD498nG7a2GKTIGmgT>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 14:01:05 -0400 (EDT)
Date: Tue, 11 Jun 2024 12:01:03 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Jiri Olsa <olsajiri@gmail.com>, Quentin Monnet <quentin@isovalent.com>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v4 08/12] bpf: verifier: Relax caller
 requirements for kfunc projection type args
Message-ID: <3ys25qg63cfuxjclqjlagsasvp5bpu6oqzjeia32kg2seistbv@5t24bsw5jtij>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
 <e172bf47f32c6e716322bc85bb84d78b1398bd7c.1717881178.git.dxu@dxuuu.xyz>
 <CAADnVQLE=XcpZ4SnW=NARG0D5Ya6iU1-1CayTVmArnxpSzWSFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLE=XcpZ4SnW=NARG0D5Ya6iU1-1CayTVmArnxpSzWSFA@mail.gmail.com>

On Mon, Jun 10, 2024 at 11:30:31AM GMT, Alexei Starovoitov wrote:
> On Sat, Jun 8, 2024 at 2:16 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Currently, if a kfunc accepts a projection type as an argument (eg
> > struct __sk_buff *), the caller must exactly provide exactly the same
> > type with provable provenance.
> >
> > However in practice, kfuncs that accept projection types _must_ cast to
> > the underlying type before use b/c projection type layouts are
> > completely made up. Thus, it is ok to relax the verifier rules around
> > implicit conversions.
> >
> > We will use this functionality in the next commit when we align kfuncs
> > to user-facing types.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  kernel/bpf/verifier.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 81a3d2ced78d..0808beca3837 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11257,6 +11257,8 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
> >         bool strict_type_match = false;
> >         const struct btf *reg_btf;
> >         const char *reg_ref_tname;
> > +       bool taking_projection;
> > +       bool struct_same;
> >         u32 reg_ref_id;
> >
> >         if (base_type(reg->type) == PTR_TO_BTF_ID) {
> > @@ -11300,7 +11302,13 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
> >
> >         reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
> >         reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
> > -       if (!btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match)) {
> > +       struct_same = btf_struct_ids_match(&env->log, reg_btf, reg_ref_id, reg->off, meta->btf, ref_id, strict_type_match);
> > +       /* If kfunc is accepting a projection type (ie. __sk_buff), it cannot
> > +        * actually use it -- it must cast to the underlying type. So we allow
> > +        * caller to pass in the underlying type.
> > +        */
> > +       taking_projection = !strcmp(ref_tname, "__sk_buff") && !strcmp(reg_ref_tname, "sk_buff");
> 
> xdp_md/buff probably as well?
> 
> And with that share the code with btf_is_prog_ctx_type() ?

Ack - will do.

