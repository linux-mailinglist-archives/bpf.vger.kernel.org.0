Return-Path: <bpf+bounces-71478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A6CBF3FD1
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45FE426356
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4712F5333;
	Mon, 20 Oct 2025 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igjaySzm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A952BE636
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001719; cv=none; b=OA7AXahVX17mKKR+tsmvafy0LafLw00BojjUYIBLb60cxyI3wLHhyv4rbwEboUD2SQdxUJaCoOWPas7z8VffzC2/nBpRoavZtTQ5+0nX8pfSsnoNlSDVizZ9kHh+k3syD0zLW35I8g3nlXZWCRaiu8EuU3HzZym8PX5oiOGA4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001719; c=relaxed/simple;
	bh=ILbZ8+vg7s7jWdAEVj/oZp3189D/eXNL3qaJel6b5XM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ns7e3OELER6o8LObmtyOGVIN00BPwWel0sjorqhR63+0mWa5LkOzIkd+UJnyR510kpfpdTpOQge8UYL3kGUNS8jbiMybZorGyvWjEKFLq3Gi5iYAwrEjqcLUEAVpw46M3DWxmyMmt/aOFGzdFYqXGnFh/99rMvFpL3gEpmnKrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igjaySzm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290d14e5c9aso44303955ad.3
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761001717; x=1761606517; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BYL5rzW17TM4IbDJWohi0akqir6wwDJHaPF0+Y45hjg=;
        b=igjaySzmUDu+TwrIzYbkKQBR2L/AYR8sEehN3wZeuAk1oqRz/8/nOJQ1O/ir3n1+/3
         104LXK43ajOoosb0rUk1qM7FEpsduXZdkpzPXO6P8e7z8bhZmLprtM+7+Ai01B4zoVKV
         wy4dvMCFo7keUHLo04k4d6uhgFZlVJSY8kxEKlg815ca0lB5gHp1ALTqKy0rSdR70LWR
         fHaNL+qVKhZPxTJMemsPxKd6Gy7YVrcrLzEG+SccT63veqQOOPIB66D6+0ZPPNFrvAjr
         uQL1NjtyyolEJvkR/G1bWda/Jf0DtdcXoJjY1hNPrZjWYoXdYSC+GPS0yvgZMgf/DtBs
         1C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761001717; x=1761606517;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYL5rzW17TM4IbDJWohi0akqir6wwDJHaPF0+Y45hjg=;
        b=eYB3z5Ut2eW4YBTQ/LugIrgFCiZ+UinPbzmKkILuFUhi4rRb/yTlzpUxdX+fAWKZBO
         z1cVn870/6tKfmlB3EW3w4o8/Ls8UHYSVYtT+G23uxLPoxmAtFkMCw4PbGgPeMVfbJqf
         HIXgl4sxGM+3C6VuEuFpqdJUhEAfrBjeJXNmKyNaB9vrw9Y9UYvt70/QSM3SYYj6FYAW
         9JiwDomhT9jTYxIehXdzdLWCvn3HEpXuAeCp78TEU9IlOFuXoywQO2qsq7hYdQRnxr/m
         J1EH7a98jjcCPW8CTu3KtKZOrWZI0efa48DSZ6igPi5E8wFP51Qvc6+4P3Lm+xT0E/oj
         oVXw==
X-Forwarded-Encrypted: i=1; AJvYcCXkvwgy3dWHXorcnaXnPOsn/j1UP3DksF2Jg1qDwZ7KOCYPZ5F57lAry9C5WORONxtuY7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcwApB1wSda019g8nw+qFvmd4RCJ9sB3rqpICqytxy+82cY9R
	Buxwds30bOgRDtmK4pt+1yNGfBcHcsPfgfPaJ3r1DODtgF/ca6WUaku+
X-Gm-Gg: ASbGncuBcE2sWSMwzk+TRfdvJ4iyRzuh8upUiVJCwR4XoQMZKeMFMt9aFINNMZVQR4D
	+LJQfe7vPfgs20kelFSB1IdH9yn3/Qp7TxNctYBX2xLMthYpqNEc2mrnC60UVleAkAYLE25L/bd
	nDFlfngCFpxIGem3LBZMOdSXYc2+Z++kFZQVgOcgb0+Cd3a7aPPySy/c+JYVGd8bRGO6FmXDEN1
	9kbSiLyJidsFBh343T+1EAcAgXHZVndN/QsEOFjcuSXNVLbMWbT4PHwCKQlIs3lYmwQLPWUCrGQ
	sRkIEapNpWwHM+GvgMeCqTRu1IsZLn1NS2D/AGaXhh81hxPT48TS986xgsCUAa18xiI/17e5ww2
	YHn5msEd3nMxW036pFtWHuVH4fQizKvh1mKIrOSuioiydlxSfr7q4IQd8VJ9WBNsJiB/WB7jQfl
	Il0RuWl0m3Wv7dWd/mEzWQejzehA==
X-Google-Smtp-Source: AGHT+IFicaZsuc8rpb++2oqYAmEpHHAd9/0zCdBB2w0JHKcJdghZMcsmFb/fyzg0SgagyDjQEkHCFg==
X-Received: by 2002:a17:902:e88e:b0:28d:18d3:46ca with SMTP id d9443c01a7336-290cb65ca07mr198225435ad.49.1761001717129;
        Mon, 20 Oct 2025 16:08:37 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:badb:b2de:62b2:f20c? ([2620:10d:c090:500::4:1637])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5bf5sm90303815ad.67.2025.10.20.16.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:08:36 -0700 (PDT)
Message-ID: <b584aaf4d7c9e7d603b041a3118037d8611417ab.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 06/10] bpf: add plumbing for file-backed
 dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 20 Oct 2025 16:08:35 -0700
In-Reply-To: <20251020222538.932915-7-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
	 <20251020222538.932915-7-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-20 at 23:25 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Add the necessary verifier plumbing for the new file-backed dynptr type.
> Introduce two kfuncs for its lifecycle management:
>  * bpf_dynptr_from_file() for initialization
>  * bpf_dynptr_file_discard() for destruction
>=20
> Currently there is no mechanism for kfunc to release dynptr, this patch
> add one:
>  * Dynptr release function sets meta->release_regno
>  * Call unmark_stack_slots_dynptr() if meta->release_regno is set and
>  dynptr ref_obj_id is set as well.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

