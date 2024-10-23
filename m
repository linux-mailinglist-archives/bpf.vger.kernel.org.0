Return-Path: <bpf+bounces-42874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5709AC197
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06BF01C21D8B
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B7158875;
	Wed, 23 Oct 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="efYyz3yD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F7157E78
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672143; cv=none; b=c+qMOaaV0/eP8oRpQgnCAg0lWVB8FIuMIdIv1dBgDU0R5JxUbCaGjvXBKf32E2T9OBO+Qn6fsnS9iKey4AE74j3NJoiXlo0YyQCLxtgE+uSG/vkpREvb1e3D8rbEu83PlnvaVjHqCPJBh8C/KINmlfiPrnr0fm8oR8AiYJIu8V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672143; c=relaxed/simple;
	bh=yi3138v6iNfT13tBZD53GlTX0WLmWFCgf4bu7g5TzXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeAYMeUk3BatFNvp3N0oAtZacjlXAsHMO+4Cag24MqBRlCNZ2PgFeNlqjtXlS6CWrvy6IAE+3wiJiVHMZ6qk+W+pJx17SvoF1qmHThqFF2T7vC7fK6ZOzosD9mcxi/etADrXgF/RiS2BbofdrPlKsPXwT/KyUj8DGonnE1ogWc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=efYyz3yD; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so70679851fa.1
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729672139; x=1730276939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tr8VpB86M8Ay09+MenlAIZ65QKq/N/01Au2y4wkGOx4=;
        b=efYyz3yDV7soodXkkoOPap6Vn+qgKGdPDiUsd8S2ZPIkC/1OMn5vgnQPpI+xRlpfxU
         MRPBq6wYEJvuM6Lpyowm4L5TfP8tmzcHt1VvLQWNSGuA6yxfHH0DyGjVZxxMLaSMHzcP
         AfdRbV9zVPFBpJ9w5EujDzw17tDYkfAx+B85AiOZwkJSPpm/hMu4r/J/5wKPO2EdgZxP
         2iFuZA6r/ZTAfZ9vYDaNazqDQrtBN2m1KRoKHsa7D9wviOlc+9LjkVlN+YONtZQCA+KB
         VsqduE+C5LYarOZC0j8etxC5TY2hhSyUnwXILwCRPn9apNObDHcdCa+hE3sbxpk6c3Hj
         snXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672139; x=1730276939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tr8VpB86M8Ay09+MenlAIZ65QKq/N/01Au2y4wkGOx4=;
        b=iGElJcQ1KSezTQlKeeGg4g4vk0mbNEDw6ZmafvXyXYlGU8cRed4o6rzcqHpQ5VY3aQ
         AIMLBk5IW3mez7JsHkVhCuP8d3el94IMargvMnrZeHAVHXiuDWbrOnEGPLUVTyymATcY
         fyhyFrzKxly18VvQKhdgvTuewe3bYnT4KUTOlgVNjLLosUWDo/jByA7kNOpqnDPuUXho
         UQPFS9EA2tqa7bHbnp4WXLYsgujh2yDhQ5tpsZE3cmgCh/fXoiUUPDodCGoRooQHi4ma
         CpM4ZZ3+ScvV0c6WhQQjCoIxqhcEs0cwHGIR2xWbLeKYXL+ypicKAMzSr+l5sxdgiILK
         Xnjg==
X-Gm-Message-State: AOJu0YxltsKKYbZwPBNb+ZbCzje1Io7SONeFMRtyAfqidXmAwhcGMVa8
	Rk8if7mMYZh7FbHhug5/SVhkRDqcFA2iBwbEbF2hTaJ7UwrVC34dTYj/eDqXtB/ZR6+pH1HQobe
	cChqFhQ==
X-Google-Smtp-Source: AGHT+IF/vFIf6oWmWDZDpKa2zQxr+SCTuvf6RsyhgilqVJ6xZE4BWo4UQO8qboeb+ybZFpE8MtnP4A==
X-Received: by 2002:a2e:819:0:b0:2fa:dc24:a374 with SMTP id 38308e7fff4ca-2fc9d581de3mr6713451fa.37.1729672139312;
        Wed, 23 Oct 2024 01:28:59 -0700 (PDT)
Received: from u94a ([2401:e180:8861:2c7c:bbd0:9c6f:9a61:fab0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabdd85fsm6275284a12.90.2024.10.23.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:28:58 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:28:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, John Fastabend <john.fastabend@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot()
 helper
Message-ID: <jnasedlxo42dwibgynuwlccwql2ca7abdoz7ihnyccer3kdaj4@idpkucm7ohj5>
References: <20240404002640.1774210-1-andrii@kernel.org>
 <20240404002640.1774210-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404002640.1774210-3-andrii@kernel.org>

Hi Andrii,

I was looking around in do_misc_fixups() and came across this

...
> +			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    += cnt - 1;
> +			env->prog = prog = new_prog;
> +			insn      = new_prog->insnsi + i + delta;
> +			continue;

Should the above be turned into "goto next_insn" like the others that
were touched by commit 011832b97b31 "bpf: Introduce may_goto
instruction"?

> +		}
> +
>  		/* Implement bpf_kptr_xchg inline */
>  		if (prog->jit_requested && BITS_PER_LONG == 64 &&
>  		    insn->imm == BPF_FUNC_kptr_xchg &&

