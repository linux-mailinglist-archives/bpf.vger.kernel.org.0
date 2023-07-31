Return-Path: <bpf+bounces-6485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ED776A3E1
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 00:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C73D1C20D54
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 22:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031211E535;
	Mon, 31 Jul 2023 22:03:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F21DDC5
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 22:03:34 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BAD1726
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 15:03:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so7803669e87.2
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 15:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690841009; x=1691445809;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w86D/JZrW7Db1uNyBD+kEVSyCSU3sQVCWnyuXVPSilQ=;
        b=dD9Gdl6Gj3s9mGxUsV9jhwgZxDfKQIO7FcWSFJ4yHzvelQoFmZ2jrRIWH5e7D36lbR
         Ej2bHMDu0VhLpP+YRvaJi542dz0IS3AWGBgYoBja5UHbZwIQQGb1pq6BQU6OBnEce1B2
         M1pXm51LEh4D2k2DGe5RXlOI31nMLRJh6ATg170xQwGxRtF+GIxwXXss17XJCLS1Iojg
         dGUC5gsamvaWN817/Z6UIGwosxGFCR0qAMeZKN1GGXM/0ftVyjLgQZEOAVSmBpwyhpFG
         TtRxJqyTLqzWxByE7uMBaiC/RfPrDCIsz3cz3YtAIwr1Zd3qrLJMUBzUXw1Es6HlySOj
         fsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690841009; x=1691445809;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w86D/JZrW7Db1uNyBD+kEVSyCSU3sQVCWnyuXVPSilQ=;
        b=C0Mpx9bVQQFMk25mWU2uorbIr9JFng4DY2GtEFRw4888R4f9JDSGGK+YGQSThh7u3u
         WQoMvrdTVyFYe2eaB/NnnFw2vLDS0lHinTUFZrgXokN6HnOu8GR8ndAgby7ftOltTS00
         FbBvxXfocVxM72SJV7wz6OuddyWr0h6xFZt8mB0lhRoLpk0c1kpHg8RTOz4VdmKcDXOH
         vOzqi7vjgkmjELkhQJ9Xz5QqHirsNEBAixGi8m6oHQ0OTHCHzK5ySrhsqwQ+FTm2jFxh
         Af1mP7PO/q6C2ATVqDXyTCKbEJxGgRc5way1E2rJv5jLn7I6pXprvENIqxTntPDMl8aX
         0HRw==
X-Gm-Message-State: ABy/qLYL0MJ79PG8PS8a6VCo8qS/S3VyPeUYctkKOToHL/6kBDzAXuxy
	uqgg8WFyXJZuW5jaVPAaqDg=
X-Google-Smtp-Source: APBJJlGOar5kHoL11HifCU52QrxtJTu7fKpwo/AjuIAkyBpFXIpnzCXi3hvsAXrxMveHCBrESyv8aA==
X-Received: by 2002:a2e:a317:0:b0:2b9:3274:dbef with SMTP id l23-20020a2ea317000000b002b93274dbefmr723041lje.45.1690841008471;
        Mon, 31 Jul 2023 15:03:28 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r4-20020a2e80c4000000b002b9b55fefe0sm2758398ljg.131.2023.07.31.15.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 15:03:27 -0700 (PDT)
Message-ID: <14e9b56db903b80d9c2ee7ccc1fbe7d795a26327.camel@gmail.com>
Subject: Re: [PATCH bpf-next] kernel/bpf: Fix an array-index-out-of-bounds
 issue in disasm.c
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, 
 syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com
Date: Tue, 01 Aug 2023 01:03:26 +0300
In-Reply-To: <20230731204534.1975311-1-yonghong.song@linux.dev>
References: <20230731204534.1975311-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-31 at 13:45 -0700, Yonghong Song wrote:
> syzbot reported an array-index-out-of-bounds when printing out bpf
> insns. Further investigation shows the insn is illegal but
> is printed out due to log level 1 or 2 before actual insn verification
> in do_check().
>=20
> This particular illegal insn is a MOVSX insn with offset value 2.
> The legal offset value for MOVSX should be 8, 16 and 32.
> The disasm sign-extension-size array index is calculated as
>  (insn->off / 8) - 1
> and offset value 2 gives an out-of-bound index -1.
>=20
> Tighten the checking for MOVSX insn in disasm.c to avoid
> array-index-out-of-bounds issue.
>=20
> Reported-by: syzbot+3758842a6c01012aa73b@syzkaller.appspotmail.com
> Fixes: f835bb622299 ("bpf: Add kernel/bpftool asm support for new instruc=
tions")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/disasm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index d7bff608f299..ef7c107c7b8f 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -162,7 +162,8 @@ static bool is_sdiv_smod(const struct bpf_insn *insn)
> =20
>  static bool is_movsx(const struct bpf_insn *insn)
>  {
> -	return BPF_OP(insn->code) =3D=3D BPF_MOV && insn->off !=3D 0;
> +	return BPF_OP(insn->code) =3D=3D BPF_MOV &&
> +	       (insn->off =3D=3D 8 || insn->off =3D=3D 16 || insn->off =3D=3D 3=
2);
>  }
> =20
>  void print_bpf_insn(const struct bpf_insn_cbs *cbs,


