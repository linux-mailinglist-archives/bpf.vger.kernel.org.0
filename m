Return-Path: <bpf+bounces-8156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E9678292C
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 14:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472DE280E70
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 12:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE25C85;
	Mon, 21 Aug 2023 12:33:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D602567F
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 12:33:48 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EBF9;
	Mon, 21 Aug 2023 05:33:44 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so2408833f8f.2;
        Mon, 21 Aug 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692621223; x=1693226023;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s3HgJkRyuOgTx4bEfnEWuZ5n/XqsWxChCuiASKyLNMA=;
        b=pRoenO3reqjH9GyQWza97sTt8mNIXpVInHRqt36XOXYaDfo2yQtE8HDiRc/P8pDajI
         Hi10HhZx2U2WkCCfAsr1+pbjgFRI3oP8IAMx5+TPFcSnC8ph4E9bl64OEu3hS0xko/xV
         /Bn9fyLVBPIcJD2gldmya9CwFIAWhY4T/xUgGztbVLg5z7haABuQsbkUqJVU8fD9w8Sq
         gp7M8+/qOpWsi2uceQU+1X10fdFFIKANFuUAu8RsczT9H9RvurRIKSe8hgjbh++y/YYq
         IrD29yAnjhqo927PJjiplk0IpN9djvNe9t7YD8kDjaC1lY9iJm//XEdOHA/zHBXlGRRj
         DNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621223; x=1693226023;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s3HgJkRyuOgTx4bEfnEWuZ5n/XqsWxChCuiASKyLNMA=;
        b=TI4R0twLeG7Oh/4VQiEAzVuNnvI1rqrEqQ2ZXcbIw5X/6nzApIBuegy/u6/hEFOfaU
         ydES3xvRhr/7gEGUwt/FpiDBYcgnJ5c9TOawaGqP9vg0RWbEvv6dAOgqNHFf4Z23fmMs
         GUZFFmga1W51KQsUsh9JqZHreZ2QHNBwvfdmeaEgW1WxyxTBFnqFYj6kneCwEz464tmD
         ODp5KeWdAvqtMw0kXJjKomUQI9TUhGAKN+8zf0297w58b778YPDYPVIzkOriyQsTzE2j
         zpMpfjfqnpuxciismlWkx91JviyfP7P4FL8CoDXXTSZHBy3erWB/skvSx3d6w0gQQ3gJ
         NmJQ==
X-Gm-Message-State: AOJu0YzraoiWLrLgTgwHnNQ3m0YHyo8OLTgFNLvxHeBynJSTIwieq4Qp
	Yj19CjxlBcWhMXqPUBhIWV0=
X-Google-Smtp-Source: AGHT+IHIP4wOHbycg4BtDdQ/IfKgJ/Js/QxGr9jLwuNJmlXq/4xyqcIUWNMXj/hv+gepTxCMbMvDEQ==
X-Received: by 2002:a5d:452c:0:b0:317:ddd3:1aed with SMTP id j12-20020a5d452c000000b00317ddd31aedmr3810227wra.68.1692621223176;
        Mon, 21 Aug 2023 05:33:43 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lw26-20020a170906bcda00b00993a37aebc5sm6390383ejb.50.2023.08.21.05.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:33:42 -0700 (PDT)
Message-ID: <6e048371123eae0f89b58581a043b1a3de36f7f3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix issue in verifying allow_ptr_leaks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net,  john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org,  yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com,  jolsa@kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	stable@vger.kernel.org
Date: Mon, 21 Aug 2023 15:33:41 +0300
In-Reply-To: <20230818083920.3771-2-laoar.shao@gmail.com>
References: <20230818083920.3771-1-laoar.shao@gmail.com>
	 <20230818083920.3771-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-08-18 at 08:39 +0000, Yafang Shao wrote:
> After we converted the capabilities of our networking-bpf program from
> cap_sys_admin to cap_net_admin+cap_bpf, our networking-bpf program
> failed to start. Because it failed the bpf verifier, and the error log
> is "R3 pointer comparison prohibited".
>=20
> A simple reproducer as follows,
>=20
> SEC("cls-ingress")
> int ingress(struct __sk_buff *skb)
> {
> 	struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct ethhdr);
>=20
> 	if ((long)(iph + 1) > (long)skb->data_end)
> 		return TC_ACT_STOLEN;
> 	return TC_ACT_OK;
> }
>=20
> Per discussion with Yonghong and Alexei [1], comparison of two packet
> pointers is not a pointer leak. This patch fixes it.
>=20
> Our local kernel is 6.1.y and we expect this fix to be backported to
> 6.1.y, so stable is CCed.
>=20
> [1]. https://lore.kernel.org/bpf/CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94=
aXSy4uQ9vBg@mail.gmail.com/
>=20
> Suggested-by: Yonghong Song <yonghong.song@linux.dev>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/bpf/verifier.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4ccca1f..b6b60cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14047,6 +14047,12 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  		return -EINVAL;
>  	}
> =20
> +	/* check src2 operand */
> +	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> +	if (err)
> +		return err;
> +
> +	dst_reg =3D &regs[insn->dst_reg];
>  	if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>  		if (insn->imm !=3D 0) {
>  			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
> @@ -14058,12 +14064,13 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
>  		if (err)
>  			return err;
> =20
> -		if (is_pointer_value(env, insn->src_reg)) {
> +		src_reg =3D &regs[insn->src_reg];
> +		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_re=
g)) &&
> +		    is_pointer_value(env, insn->src_reg)) {
>  			verbose(env, "R%d pointer comparison prohibited\n",
>  				insn->src_reg);
>  			return -EACCES;
>  		}
> -		src_reg =3D &regs[insn->src_reg];

I tested this change and it seem to work as intended. Was worried a
bit that there are three places in this function where such checks are
applied:
1. upon entry for BPF_X case (this one): checks if dst_reg/src_reg are
   pointers to packet or packet end or packet meta;
2. when attempting to predict branch: prediction would be triggered
   only when dst/src is packet/packet_end (or vice-versa);
3. when prediction failed and both branches have to be visited
   (`try_match_pkt_pointers`): dst/src have to be packet/packet_end or
   meta/packet-start (or vice versa).
  =20
Check (1) is more permissive than (2) or (3) but either (2) or (3)
would be applied before exit, so there is no contradiction.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  	} else {
>  		if (insn->src_reg !=3D BPF_REG_0) {
>  			verbose(env, "BPF_JMP/JMP32 uses reserved fields\n");
> @@ -14071,12 +14078,6 @@ static int check_cond_jmp_op(struct bpf_verifier=
_env *env,
>  		}
>  	}
> =20
> -	/* check src2 operand */
> -	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
> -	if (err)
> -		return err;
> -
> -	dst_reg =3D &regs[insn->dst_reg];
>  	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> =20
>  	if (BPF_SRC(insn->code) =3D=3D BPF_K) {


