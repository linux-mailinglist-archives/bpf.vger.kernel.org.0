Return-Path: <bpf+bounces-43847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84919BA7D4
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8718B1F21573
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463CD18A95F;
	Sun,  3 Nov 2024 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpIpfxT0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAF2187FE2
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730664251; cv=none; b=EvfUuzv4E+THtf3SHaOdRAL+JyVvB5TCHDMAy+X/XSQ5AnVlvkjPVP0pFCu0furCI0Yy958EDCSvWlGxcnKeCnyYaKSrDfYNGoS/essF+5uUoGKIhfaVRmDV7v7HccCohj1dEjP0RQ5Nm4y6zcHvjmtdL9akZGZpbz6DQ+ev1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730664251; c=relaxed/simple;
	bh=gR268y83eL4SoUEdjawan5CDepkw/mnuHvTL4r2CJLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+BIXLqnDV+2DnQjLWT0zMdJCUBzQjdSRLxwvqz6sYk0/hIQiTF+dyGnrg9KsHFs3rh9TIekQstplOsh45/VxxRbyc5xRBjpitR3vJ32OUkPmC5ADGwXXyLDGmeA+Rm898JLRSBkTEv8N3t9O9XgzVFTDFBz0V3/bu46bZs14Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpIpfxT0; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4189998a12.3
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 12:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730664248; x=1731269048; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gR268y83eL4SoUEdjawan5CDepkw/mnuHvTL4r2CJLk=;
        b=BpIpfxT0UYuDJRhcQMTTXtSNMhigViBgws0vTGjdlh6h+vQu/p/C+i1TObNl2Ll4Bk
         tbEXPjOWpM2awvyR/e19Ut4klvrg7ih47th3yYkBMIsYi2rNMD07L8N74jqhn/k6mwQb
         J3t+CnQfFv47cB6OrEiJapmi1hD2Z3xlo9vS2lWg+DubFVmxyb7QpVG4BdPekH+rGrvV
         xw0wmWXr+wpXYE/h4HBT4mrk6GpVglAVSEPJ2WgatMzSpch8z5+PeulAT73l6HAwYwTe
         zKFeXCu7uLuatGZncITNOdTMNJFwi1NnCOt1WQStYuo6/ZUDTy2VMm1fddbIhhrSI/SH
         YZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730664248; x=1731269048;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR268y83eL4SoUEdjawan5CDepkw/mnuHvTL4r2CJLk=;
        b=xDxew95mBd7KMtisg2S83GaxPvYQZ+lSQzSrZS9NMXRlbOwrIDF2eKO+wfWXj69M+f
         tACAS1SpKQ+J6+muNIjpQtn5nGeZjeuHpCeFfpf9LIaW8V6bDlX6cLSCXkHkRV49XcXp
         fkPZOeUm7obZsnCzlmK00Ut4tu9WpYam8fNkU5/Re2VApJ5kzaA5MLBmZRWhnmaiYZ96
         v6X3s8aFl3vf8sIhGH9GI4ronrtmhigmYb4kYu3nY1tF6/AoDGLyTO67jXTA875GWRk4
         VBbHFUXL4veqBoUd0dXlH4/ZrCvlRkak7nYS+eSFz7jtQCB8+Xzk3WL0y9uDAweskCNA
         ARSw==
X-Gm-Message-State: AOJu0YzT7iWnoQ1bgmtmJcOHk9/X5gJFTdCZmfEwFYUK5qABAZa16ktC
	u2yF6ENiy2j+H47OF3lkiEO7FSpEZG2f4SDDRtyOlcOZqoep6MNLdR9ODCS4bkZnsgOV6ah3r46
	GK6V/Rcq9sLD0MpKq8bjMyw0Lskc=
X-Google-Smtp-Source: AGHT+IGDRuhuq0N0cX8s7NHM21xtEJEGeWQ1015fSdIqrmyEUo1+bkLUpOXABC1DR1rL1Qb78zb58kMK2UI8U3k/OGk=
X-Received: by 2002:a05:6402:51ce:b0:5ce:d397:9ef with SMTP id
 4fb4d7f45d1cf-5ced3970c66mr2005372a12.27.1730664248190; Sun, 03 Nov 2024
 12:04:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101235453.63380-1-alexei.starovoitov@gmail.com> <20241101235453.63380-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20241101235453.63380-2-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 3 Nov 2024 14:03:32 -0600
Message-ID: <CAP01T76==8ABkB8ptWZZkwnTcfPHWzXUQ3oOjEiQOvod=WL2ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] drm, bpf: Move drm_mm.c to lib to be used by
 bpf arena
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 18:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Move drm_mm.c to lib. The next commit will use drm_mm to manage
> memory regions in bpf arena. Move drm_mm_print to
> drivers/gpu/drm/drm_print.c, since it's not a core functionality
> of drm_mm and it depeneds on drm_printer while drm_mm is
> generic and usuable as-is by other subsystems.
> Also add __maybe_unused to suppress compiler warnings.
> Update MAINTAINERS file as well.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

