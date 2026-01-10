Return-Path: <bpf+bounces-78439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70095D0CD85
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECA5D302C106
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBAF269D18;
	Sat, 10 Jan 2026 02:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bziJjKEM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E876238178
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012837; cv=none; b=pOBztsvSLfl3O9bz01UbLXZNC6mRNNaZgcfxzJx4zFUv3yS2J6uidKDIdm+G/N6u5/NiLF5olFSP2cHgzlm90ovhzG4wn7PLLD8RG69RLJ247tCQrEO1ba8jzGBoZis5wUswVrJJKp0XSByzH0WckdpVn+hIS/YTimR++SEeLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012837; c=relaxed/simple;
	bh=1SxIsqUEAexn1us/dXgWbqN7KGJyaebrlCFgxxvhPfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSqKxoJDQmmgGcn8JO6tZ44ov3Njg2EIx2XZLmr6oTF3bCHexHpyrl8COO1lV6BRR4m0Tj1X3vcDy3MxloWg+q5/uANSbmexus8PeOitZ8iz14m1g7vYLiphWcQV8scTBf8g8rdtLg7PPUzb+l7WduZmt9KiRlKyJPCc/27K8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bziJjKEM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3625941f8f.1
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 18:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768012834; x=1768617634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUPhPnertLhe8Dwd6BnBPWZPWRSSVIbsf6i73EuWKvo=;
        b=bziJjKEMvDdLATsU8zdIBO9GMWE70znypkjq8QqhN+EDporEAaVMQ9IHwMiZL2L9I9
         GLj4YdtBhlB3gm+3xpmq3L/hlA14OP2y4UCVg8XKwDnJ1mxINNKV+DXrevJe30E5GX7i
         el/FsM8O64BjR5yczuQs2CABTXqKFNDIhd0Glr7fhlj9gE5iSmMEupC7dPh0RxFEDm9k
         cRWEory72teO5ppxnBfv+qFdrDs/w6jk1XHZcliD66vEKCM9S1mwowsr9idUEqYMdEQu
         DIJgTRG6yacuX/nkji8NtmjY0BIE4Xki31bbcPWCEO1F1sXF+UbZh1l/Vj7rl9CIc1I/
         wbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768012834; x=1768617634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wUPhPnertLhe8Dwd6BnBPWZPWRSSVIbsf6i73EuWKvo=;
        b=gYUBLNM1vzMNw2+Xm9JljRKn/eOcg8aYdqzbfT+MX6B+J4H9Qr9toHbSiSdnniCl5I
         PcELal8rPr2pP1BpZfpy+HBJRbduyWOlDpY6BpXDC/PjwOXKlMiWD/XZanC5eXzMv8XX
         Mrr4+hPFrBEB5WGido6n6nNTScDunF5UqDniDy8KdZuBu/cS+PQLZntLgFN3eHXqW9bX
         A8oSEeXsCWMMl+AjFKgL6oMxWtmM9B+OkBJQgIFpl5qP3EWn6SVXGBzxhu3xL7GEkRmq
         0rKPCM1E0XxFBGNW2t4GV3seywkxVTGEkY+ZPoY/B3xwe6Jh3YCEK5oBN7UezBMyrZOB
         HwCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc58kjEzNM/GAzgye7n5otjM2tT3sqCX4q1xYFRnRc8Yx0d41sqgfLBdgLDhSHpeIh9iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFagv8gYQ9vxIX1Hh8M4vNAmaHoL33x7gWTl466oGY20FEdvYW
	+7hR+D2zQbUc9DlqETE57/lZC9bcH5IlJIf+MZy4Kqsqle+w8aJi5Nge4WG3TLEoW53CIs/S/f3
	3D4RLCvWkpgZwVawMV8QgUdO/8i/6rT4=
X-Gm-Gg: AY/fxX7+gvN5zxtwM1jTuwtmqd5F8ni876sJwn8z1kRpTVIGW4npaUYRg52lEDjA1Ny
	OV8ai95/4xY6VbRuWyRSn9mABn6EAVXyGBSZhBKEbKgesRzvDOZ6YuTvWv1EhODwvKF0sOZFE5t
	2syOK3pORVDnWnyghjLwRZipZWB8BGcF1iekrCb8eObdcjK4EC6qu+vfpjDH08Tt7kkqey4H24W
	6s0ejCwR/O9UJmv9poGp/CNTOE6PZyUkDzyU+4+E0XzkSW3HQktLZqvItEDGT3kUx+SETJmrYWl
	Zgb2AQAjGJllXORTVmH+tCGvBDaM
X-Google-Smtp-Source: AGHT+IHUZuAsyb3vQ91cVAoljiuOY2kpXkAZ+YC+zBkbNxTarYHC+smPORFxQkwRxluy1QTn0hufXerkK5Vx5AWIXN8=
X-Received: by 2002:a05:6000:2886:b0:42f:b581:c69a with SMTP id
 ffacd0b85a97d-432c378a894mr15215276f8f.5.1768012833811; Fri, 09 Jan 2026
 18:40:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn> <20260108022450.88086-5-dongml2@chinatelecom.cn>
In-Reply-To: <20260108022450.88086-5-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 18:40:22 -0800
X-Gm-Features: AZwV_Qjn1VvPqinFnx4m7uVmtKxhbfLQEknzypym2_Xevslb15VlVNmv8ccYnvE
Message-ID: <CAADnVQLj4c-nc6gLbBiaT24KXWEpG3AzFT=P1tszu_akXhyD=Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: support fsession for bpf_session_is_return
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:25=E2=80=AFPM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> +       } else if (func_id =3D=3D special_kfunc_list[KF_bpf_session_is_re=
turn]) {
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION)
> +                       addr =3D (unsigned long)bpf_fsession_is_return;

...

> +bool bpf_fsession_is_return(void *ctx)
> +{
> +       /* This helper call is inlined by verifier. */
> +       return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> +}
> +

Why do this specialization and introduce a global function
that will never be called, since it will be inlined anyway?

Remove the first hunk and make the 2nd a comment instead of a real function=
?

