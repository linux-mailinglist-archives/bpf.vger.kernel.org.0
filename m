Return-Path: <bpf+bounces-75079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1022AC6F01C
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 14:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51D453A02D4
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9D9351FDE;
	Wed, 19 Nov 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVF1LU70"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB37F31ED96
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763559429; cv=none; b=k5KWMSFjo8SxytIf1vYAaqiJ1M9iBHrPtLmSTA2SeI1TpRumGF9H0eQuojomt8/W6mig2nDlW8inUuYgxe+nUBciwdF/ExuHt1wpbk90G3P40b3UuAQ/2+ASIiSglrcq0JLW5b3jlXkCztTmwSOYWsFYkTRik6sVfbt6vq3b9yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763559429; c=relaxed/simple;
	bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP/r08QZqtGqvdJ8hKHWwyZ1irLq1vgw6TZtoO0VrHUQZKmOQAhe56KZTfYq3Ks6c+a6PGEHRqoZW//Clf8ENyexDnS9QTaVaziPOxl1qEJhEw/QPzUTkNQ/Ee++01fx0en+7KPLQxt+5XzUIrTqE2JBfWS3cuqMECR9bgAnxIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fVF1LU70; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b5e0323bso3612045e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 05:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763559425; x=1764164225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
        b=fVF1LU70knztmBTRWnLmRZoT/BsDpBPNE8/Ba/j1ZhhS5DpE9pbq4hQtF0XmSnAnkE
         W1d2xQdtdE2X71r9kE6wpN9vGElIDlBoVkSCcFWmnBNK8HFHK+Pn2XA2ZaaOUqpjGyD1
         9s8gSGt44BUGzUv+HocC6ijaax8JjPh6UR7qZz9eN3NUwVPUWhxtGZ7XIHR4So/LnkPQ
         wyeX7ZBIMjOwZz40Q0v36GoZAgIHV+E4jkHlI8OnnzH3JTArcvZOeCpfcb6rDKxvcorm
         nRN0RyRLMAECpMKV+4nPdLBuAfrFN60MSjysn1d0JbtVr+qych74x9Dmy+E5AHmv9I4B
         2X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559425; x=1764164225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/QnWL633DATk/D0Ttai9VtCMe1kqYKn1pLuJll4508=;
        b=p+Ia389J0FS8l6NLAQKYDRm/J+2Pb/NqRdLe9SrIuDdxnvinh0qjvP+WXExbKl+L7Y
         CiAF06/Q0UCWI6+Mwyx+7weJWS7QX7nXA0bqxjgAThfsmGgIWy+lEVoKLnd440xcoTGV
         2F8Ll6I9VfyNS0s0C0QEE8E2BOLPacMbYVmBA9hQxGucjm2aWHy6pmaB2aoZllcqBl3/
         mUWTw6wjPmeHtEip9LTdfzQDhvozg6IzkXrO4Jg2dwbmZj3kze7r1sTE14tAImMYj6h6
         kqNiev/HxIHEWklHtkbzzopMIc4NcOk9/N+hLtfmv488etzCW8LFY/oyDhZeqrIB6XtX
         4N6w==
X-Gm-Message-State: AOJu0YxkhTTqYssErj4+5N83EAq0IkXAYk5LR/u9X3HmZwtGm9tey+Ty
	oP+5f+/RD1qbDE7dEKWzmeSppEMYvoTOy74KCsHPA+tJ6FKC215+P00RRyc76CW0qKGot65f9GT
	oHrKA
X-Gm-Gg: ASbGncvAdybtfDC9qz60ZJz8t/v160b9+YD2NxHdJa4TT9IUIViwi9oNv5VxUnsDL2x
	stzF+tSzmu8in3KqShzoDIQ5+bpBFib04ajvwAFRjinQkWyPbxF3g2VbSdQzKVXDRG1lrufp6uJ
	2/nhgAgU/V4CKKeMO4wb/AHSgMGLkFdUMrgkWRh8ZBq7sv+XW69ahUN5/HhBP5gIQz7rUigJuKW
	tQ8zb6CDOC8Z9P9pwFxwx062ww5ghQc6pzYU8eGjBcRIu6b6+nwmW0qJ2glyrEVtxBDTuCVtnEn
	kGMeyus1p8mi7Ec17FTfb33G1bhb3DffIZtMRlwBuayy61nmurt+ytr0JLZM6PmUPbzOlxHncF/
	hjpNRZgGckMZUzD86gTVp2Ej2GTp9OeVjoivf8mhhJd2Bsjaj56wp8lSw4Vk1OOE+ea4Eix2egA
	cgrMTzYSaBhf0+3k0qGKTk8EnExL0=
X-Google-Smtp-Source: AGHT+IGxhfSAujpM7cgmzvE8Qzlmrs+hMBlnEdO25HNU/0dOq6EmoxW5dSGHJxLk+sQ2ODVpgsBPGA==
X-Received: by 2002:a05:600c:1c87:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477b18c1aecmr30975605e9.7.1763559424795;
        Wed, 19 Nov 2025 05:37:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477b1076865sm49562765e9.13.2025.11.19.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:37:04 -0800 (PST)
Date: Wed, 19 Nov 2025 16:37:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: add a check to make static analysers happy
Message-ID: <aR3H_Wl02NtiFRt5@stanley.mountain>
References: <20251119112517.1091793-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119112517.1091793-1-a.s.protopopov@gmail.com>

Thanks!

regards,
dan carpenter


