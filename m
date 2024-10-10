Return-Path: <bpf+bounces-41646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F4999407
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790F128303F
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE01E1C13;
	Thu, 10 Oct 2024 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOJHlkwC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6331E1A1F
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728593855; cv=none; b=ccOImEQkpYL6CMFkkNCLHuafqefuIrilRbOg3Zye97GWwxQqqgAcaRRmmpL8Saq5mr7V40OUrHWzkoiRUB3VYMaDc79dDZR5BA8+fLO8TBTcbzUbgctRLAT7tg7733ZSgXKaK4eYfWqtZT++NMHCTT0otjackdW2N4lFi/VFBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728593855; c=relaxed/simple;
	bh=S5+NTtNLptk9/qWHBfuR22/dTSmGVu5x4Sy495a0eAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YVUO7/ASvnUVO6Qe/rYfrBgxpG9OMLJ6Izr8GsYCN0fMRx41vhBZExbJOiJeLkmLkeVhJO4gUZ/1EECzPKba/osBHBhjAyDtWWMkGIduT4C3O46N4aO6HsmFSYKMy/bG/+iFscUDGRSiPRTBUat5eREK+t+p0Kz8uJ5yv+rP76I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOJHlkwC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71dff3b3c66so952217b3a.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728593853; x=1729198653; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S5+NTtNLptk9/qWHBfuR22/dTSmGVu5x4Sy495a0eAE=;
        b=DOJHlkwCoRJQE7B7K0oDL7Xg2kBhUHl5VAnTG1WjPJSjqgmzsdUggUdHeU+8TaHC3s
         94aGbPgOBeus2Px5H8rJYprrpLtJVQiP+0DRh5f5ltFLDEakYNRi93BBra5rUEnHp/sU
         wTndZNHUZqNzuTSnHbaW0jDx8F7MdjRgK2gdXha3t2HZ3Sa5MjTgpd7wodhWyk4Uhfbe
         asQOtrnNvQMCu1E8ifzQXLZkGaQZ+LH7wkMD7MqmWR+CIWyCK/i7ew52NIAg4S5QZJqL
         +EGzaVhlKLkTfIY4gsaP39tuSNZazGESqKRIPywc/9liWRODqXgGDqM5TMZec6p3qOhU
         CZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728593853; x=1729198653;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5+NTtNLptk9/qWHBfuR22/dTSmGVu5x4Sy495a0eAE=;
        b=HxUaNSUKbo3OJOKSgaoAgp5dK54zZSk+D7Rzo3YSFPxkz+UYQ+9UyI0s728OUayEgQ
         3EI5cuKWw+RZy6UVM3S2lPU5Y0h3V747c36xBkepL/B8JQDPpa4xLPtuKnuN657NmtkI
         /8R/BnQksvN9UAUpD9gf5cF9YCJVCxp0ZkvPAAgb+ynTn8XfgKDyYcyJrfRWqJ+pJ+y7
         7Jqo53ii1V2uCcrVUtXXQexn047uyJ48ASBdnHmWqQ1dBnBuFZL+ufuW4EZoRK8NzWW7
         /L9WPKyU/VX75ouZDPXlwaLQ2YLJSEPvPhChbi2rr3XQjOt3sbdGQhrIfErmd9JpapeQ
         wzXg==
X-Forwarded-Encrypted: i=1; AJvYcCWWuuunJyHqSzrmr14GuMmDtgHIVb8+XbG9ARpaNNK/YmnJrSuH7aINCW0YYaoA9dA/Db4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKd+kVanY5bIvDlYZ9dTM3S2mHuu3Ho3iNWv/vEbOecpvoaCyE
	WLRu0lB2N+3bEevxj/Ly10rZFfMnV05AA8FOjHKW5MQK0wae2s12
X-Google-Smtp-Source: AGHT+IHAFfOypGMH2P41aq7IWIoK2GIQcjTzRIWHFUf044cAJ6YU83Lu+0cqIPhaRW8XCuZWHR3L8g==
X-Received: by 2002:a05:6a00:10c8:b0:718:da06:a4bf with SMTP id d2e1a72fcca58-71e37e2840cmr388447b3a.2.1728593853228;
        Thu, 10 Oct 2024 13:57:33 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:b5a8:9248:40d3:6020? ([2620:10d:c090:600::1:770c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495a467sm1189616a12.68.2024.10.10.13.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 13:57:32 -0700 (PDT)
Message-ID: <48e8edfd45dced67c32866b8d669bc49d2d01988.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/16] bpf: Support map key with dynptr in
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Song Liu
 <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com, xukuohai@huawei.com
Date: Thu, 10 Oct 2024 13:57:30 -0700
In-Reply-To: <39fb92adbad5bacbc2ca9653d346c28ed2e9b3d9.camel@gmail.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
	 <20241008091501.8302-6-houtao@huaweicloud.com>
	 <39fb92adbad5bacbc2ca9653d346c28ed2e9b3d9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-10 at 13:30 -0700, Eduard Zingerman wrote:

[...]

> The logic of this patch looks correct, however I find it cumbersome.
> The only place where access to dynptr key is allowed is 'case ARG_PTR_TO_=
MAP_KEY'
> in check_func_arg(), a lot of places are modified to facilitate this.
> It seems that logic would be easier to follow if there would be a
> dedicated function to check dynptr key constraints, called only for
> the 'case ARG_PTR_TO_MAP_KEY'. This would als make 'struct dynptr_key_sta=
te'
> unnecessary as this state would be tracked inside such function.
> Wdyt?

Just realized that change to check_stack_range_initialized would still
be necessary, as it forbids dynptr access at the moment. Unfortunate.

