Return-Path: <bpf+bounces-76238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 308EDCABCDE
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D49A300698A
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACAC26B0B7;
	Mon,  8 Dec 2025 02:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si7PXuS7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7202472B6
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159703; cv=none; b=DsyBc0ddoNBOH0AzrkSVPRTzOrf70d2w+cWtNZ46xXhzgtwv8RvG3rY9gh08v0D326a5drFmdcpvzVUg1kUCw/zl7095RRqm9HMudHOWY+F/sGi90mOQxeQfoGdnuemoHMBy2KWiDN36hakS1/QmxYlgxHlNj+Ji6c9kxx6JkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159703; c=relaxed/simple;
	bh=1Z/+OclvDb/QJEMPuUUDqRU+0713jgP0rhXUDCAKbe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlD3YOeRGLc/0HROXnJkfFJS8DlEkfz3vlAiwZJ/XaHoTE2WU+sU6mi6TwlOZg1OwRPFhMNmuLBaTohUuuEnTADvZSWDwJKNR8ohUm578b0fs5R4zv3byiAZDv9K9M0esM/Yi05UjmaLRoFYj5tkxCEtDYoqOPrSxLss0kywHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si7PXuS7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2984dfae043so39587835ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159700; x=1765764500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ur9FGSBueWytPhLArbErtiM+XTB/DkACuPHhikFkRJw=;
        b=Si7PXuS73JDK1bwt0I9GMIegG+o7uK+6NDNEugi67RqFCaYj/7U0eh0UijGE/ELkiy
         eofQoC6w0PSyT+lcTp/qwSW+cfb90fR6BZprhU2M3dxfdGPQu14wsFmYSIn8H3WKnqmU
         NNjzRCRi2O8C8OqlDMWkanA7oxMr5iRWLvuEl4SnaVIYiQWdSultxn4agzg1J3ZilryV
         VtebWyirjUc3u1rjCFhhbXsUy8rHpkDgdGDbRhRTGhm3pbLlawQ7Zglms6LWT+YgHmJo
         0sgaQZSeMG5bFK+rRA1LzTkNwLSx/zzkTsCA3r3+Cms259U2HvAVqznAzt2gWgsiX5gU
         CQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159700; x=1765764500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur9FGSBueWytPhLArbErtiM+XTB/DkACuPHhikFkRJw=;
        b=ZGtOaNZPivaQIEKNy/BP3n+hkQUtQH7QBzhu3QJvB7xRh3JewJgQsdoN8uADfi4S8g
         NKOfiwlYsjU9IHkdR1z58UxoBLJYfBM8vqPwMWTiS8hWzbI1WaXCUVr3kc0AxpBFC0lH
         SlniIfZI1ef10SX+3uSpGFbsRMaTHAiY4B1lThh3IlDVJStxhuoQIyXyx/U1j7cgVUyE
         cMdm0Ezl++ixolYfKlPRaseCLf6gYKOeM7HAysGS+MQwH6B2SqvxdiGRacVBINvlaESv
         UunmerTqr51zh2HZtRUySUHKBMP+c1oZKweRHKefostWtkoqFR82z3vdXz1P51HR6uzF
         vvbA==
X-Gm-Message-State: AOJu0YwbHEtrlxw6w43w9ELLvlYTVjEaMo/pKHFneNykoT70VgAOViI8
	DfUunFuv0a9kIeo8khL8x4sJdu50+6XerBdfWepsTLH6GKuSx8TJjaHEh6WQ0LWM
X-Gm-Gg: ASbGncvF0WykArjlMuGORW6yDUinpafpnluCAe/z19raUgvQXH8+XkeS4oF+GryHdEF
	8PF1TH5PuxPXVLLfCve42pCmWezuAO9MBq+e0HrSAP+AW567YVKjrc3xtM8r0CFTPc6Uai1k5le
	GVp0NpUeI7qa6SaCueyiDgpMbm4QO4AqDmp2HdRanYTKJQKckaVkdQbYTovMRm4QSCdXou7NnY4
	/YERgiGAAv4IingUymb5BHNLG7xoUpy/bNOnnh0A96wJQgnOSP+u91oeo6lgV8H+zXBsV4OTFha
	vn/PkmbPeRFlAVFfTFCnp/mNBTfMgJ7zG2735f1dqFuo6Q8IvTv2hJRkIIGDaf6PUuvf8+A2CkK
	YTg6l0t0DLOOKJpCp3FpNlMCM9gBIHWGl3+cgqjw+5HIfCw6+1ZKsBhGJuHr7HUk7NvB0Id4QJ8
	CZyo3NC+/45Yiz+CG6
X-Google-Smtp-Source: AGHT+IFJB65l0xJT0+rhtWr2JyksUiSTAYYwhFH/IuBABX8cT+EyUly99H+EcG8ZTc3UiBiNqdA15A==
X-Received: by 2002:a17:903:1a68:b0:29b:e54f:936e with SMTP id d9443c01a7336-29df546e985mr43748175ad.8.1765159700180;
        Sun, 07 Dec 2025 18:08:20 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cfcfasm104987355ad.41.2025.12.07.18.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:19 -0800 (PST)
Date: Mon, 8 Dec 2025 11:08:15 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 4/8] bpf: Populate inner oracle maps
Message-ID: <55a2b85048d55b057e1bfb1cc17e9f5b60a72505.1765158925.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

The previous patch created the inner oracle maps, this patch simply
populates them by copying the information on verifier states from
aux->oracle_states to the inner array maps. After this,
aux->oracle_states isn't required anymore and can be freed.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/oracle.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/bpf/oracle.c b/kernel/bpf/oracle.c
index 66ee840a35eb..404c641cb3f6 100644
--- a/kernel/bpf/oracle.c
+++ b/kernel/bpf/oracle.c
@@ -109,6 +109,33 @@ static struct bpf_map *create_inner_oracle_map(size_t size)
 	return ERR_PTR(err);
 }
 
+static int populate_oracle_inner_map(struct list_head *head, struct bpf_map *inner_map)
+{
+	struct bpf_oracle_state_list *sl;
+	struct list_head *pos, *tmp;
+	int i = 0;
+
+	list_for_each_safe(pos, tmp, head) {
+		sl = container_of(pos, struct bpf_oracle_state_list, node);
+		inner_map->ops->map_update_elem(inner_map, &i, &sl->state, 0);
+		i++;
+	}
+
+	return 0;
+}
+
+static void free_oracle_states(struct list_head *oracle_states)
+{
+	struct bpf_oracle_state_list *sl;
+	struct list_head *pos, *tmp;
+
+	list_for_each_safe(pos, tmp, oracle_states) {
+		sl = container_of(pos, struct bpf_oracle_state_list, node);
+		kfree(sl);
+	}
+	kvfree(oracle_states);
+}
+
 struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					 int i, int *cnt)
 {
@@ -141,6 +168,10 @@ struct bpf_prog *patch_oracle_check_insn(struct bpf_verifier_env *env, struct bp
 	insn_buf[2] = *insn;
 	*cnt = 3;
 
+	populate_oracle_inner_map(head, inner_map);
+	free_oracle_states(aux->oracle_states);
+	aux->oracle_states = NULL;
+
 	new_prog = bpf_patch_insn_data(env, i, insn_buf, *cnt);
 	if (!new_prog)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0


