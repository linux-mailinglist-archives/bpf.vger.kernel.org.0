Return-Path: <bpf+bounces-19177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DC826A6B
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E47282832
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967E9E543;
	Mon,  8 Jan 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="GG1xZNxG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFD713AC7
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 09:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so1690952a12.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 01:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1704705264; x=1705310064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDFRteAm4wd6GlX9tJW79V47HNMeXV0mDZH/Y/EDQaI=;
        b=GG1xZNxGjvXgRqw3KmuAF59xyPju5KRFCM2rIIOhAUnoqtGVso96W1YSpNXlOzHktV
         28zv7mzTmijz9bfpmzJsg7+NfX43P2BBH6O3bbBq+cwtI//zyhJmpnfLkGcSWTk0uFQx
         R1QZ7GwIpwtqId1OB1JInfLo1WwL6mgC1+4UI0Y36dqK25mawV+WQat5hDQ93oWjqrMe
         tIX3rdNQPnD1yxiXZYIR2+ZF6MBWWXvc0BiSMuPukxaBoRi8VK4bT68wSkZ0KdH12rY4
         GVY6BekZktMk7XbeHTSZyhg7QGNp8WJKzTeUb2Wien9LcwNOCM2d2XzYHxte6a3hCL9M
         pEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705264; x=1705310064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDFRteAm4wd6GlX9tJW79V47HNMeXV0mDZH/Y/EDQaI=;
        b=jbHhVTPPyGM6vCAUDYy4FWHzmgjTqG7MASZ8jzR4nDwxNkiHwXZxexWlQmKe+qI746
         TVLz9ESftjnKTJI27qtCquXuFha8BT2GDMuGvwMz4XWy4tzAsnXM4v1pgXqkj0oExFeX
         PgZuuIzh1qbuJHNDtR9NCTCgIWqmP5EoI2E9B818Nw4iPfut8W1xZBWFzwQiEZ0wJZP5
         4MGzsEcl3eNu90CGpKEnKNrWHCHYPjJBHcNNhYOQO1Coci4pnXdep6G4Xv070yZ+jIdH
         vlCXv7mI2pTVly7sTZ78kuHqZTKazyScvJtIgZ/jSjfjE4+JSYiiP0KvJadaF2HVMI/4
         XqzQ==
X-Gm-Message-State: AOJu0Yx8mAvpjQ3JguttqIvc04It91Iu10sLglWFnc4ylf7HzEI8JQ8F
	aYnzQAjgotRu9y7pWVi/Dsg7nG1lINd/WakT683qT0eL/97wsQ==
X-Google-Smtp-Source: AGHT+IFMPbT6CeTP3RZkyoNm5olSWP+ULP1JDel/8eybpZGoMegh6v8SpTzfzeejkGNK3uL3+LsOTv17z7fWiFHQOK0=
X-Received: by 2002:a17:906:1916:b0:a1d:932f:9098 with SMTP id
 a22-20020a170906191600b00a1d932f9098mr1241974eje.97.1704705263888; Mon, 08
 Jan 2024 01:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1704565248.git.dxu@dxuuu.xyz> <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
In-Reply-To: <ae0a144d9ade8bf096317cc86367ed1f5468af25.1704565248.git.dxu@dxuuu.xyz>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Mon, 8 Jan 2024 10:14:13 +0100
Message-ID: <CAN+4W8isJzy=J_CciNqwUa5o7wu+RQ1_cvPYXt7_OkgjPycsDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: btf: Add BTF_KFUNCS_START/END macro pair
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, alexei.starovoitov@gmail.com, olsajiri@gmail.com, 
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 7:25=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This macro pair is functionally equivalent to BTF_SET8_START/END, except
> with BTF_SET8_KFUNCS flag set in the btf_id_set8 flags field. The next
> commit will codemod all kfunc set8s to this new variant such that all
> kfuncs are tagged as such in .BTF_ids section.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/btf_ids.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index dca09b7f21dc..0fe4f1cd1918 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -8,6 +8,9 @@ struct btf_id_set {
>         u32 ids[];
>  };
>
> +/* This flag implies BTF_SET8 holds kfunc(s) */
> +#define BTF_SET8_KFUNCS                (1 << 0)

Nit: could this be an enum so that the flag is discoverable via BTF?
Also, isn't this UAPI if pahole interprets this flag?

