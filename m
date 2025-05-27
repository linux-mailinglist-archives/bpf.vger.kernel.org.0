Return-Path: <bpf+bounces-59022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA233AC5C2B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D513BDE80
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289262147ED;
	Tue, 27 May 2025 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyjGLIKD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16721421F
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381219; cv=none; b=NJ/bnUhTDJxu8IJtezy1lm5TtghbIUUFJH4+mmrsrEMMdX0Qk+Us31+RYjLTj8eMsgVhMRBHx8GIoVlmF1jwAZtYY68L/Nnl7DsNrQJ1AuT4tYqIVLXhB9xf6I0xZTclix74BcWtGiqb54kJ7HjVQGn3/hzY0jJBt7bv1qad0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381219; c=relaxed/simple;
	bh=hnPdQO5S8LTk9ISl9rv5SyE/38kReukIUnTLWHQUz3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hwU3CcfEBe1xBT+IfY8nNQJCMB19TorIxBoHektLcwU5uMAlhZtzDdvOi2K3ZN8ij5qRVPk9wikl6Thyealnwj8TWXxvNg/tu+FyeJb6HzfhO1k9Gt2lE+wkvDLsDhaMaNUt+DeevNYadYtlbpdbNZr4TsLRG25Z9V1SrjxmgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyjGLIKD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so228066b3a.0
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 14:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381216; x=1748986016; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hnPdQO5S8LTk9ISl9rv5SyE/38kReukIUnTLWHQUz3g=;
        b=eyjGLIKDdog+PZ8MDkiPxB9ie7UohDOrxCZ0t61bK+Qjfkosl5qwKQqo3uYllR6WZR
         NydiOAZPGoJJFNcIvM27z95P+xLr4gnjZ0jBEPk3+TP39eklA/JhyVQiw0WZtEBjYWbt
         GTGBFBhzAZ/eA372wyV/BgClHugdEjCWKlQCSulGbxkc6tjjQC7hUQptMx2XgKqreu13
         IFRFl3LkX+wVXc9vkXKsynfSIDIzsMBQLKmAOC+FQDqQ3A6SPnfc2nxXjI5aiRM7GMnT
         DdvYzne82aRrCETrXbCRYMptpNHPDNj0ueVlXl05+dnLcOR17yA9EH6SzX2PF58UCZ5k
         U+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381216; x=1748986016;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnPdQO5S8LTk9ISl9rv5SyE/38kReukIUnTLWHQUz3g=;
        b=B/Di5Sb1Yi6xB1rqdupyRiSq5axuDgjw2smvMxESKF/Fv+WyNU5h58Y9DXwG/f6cGg
         OvE/ITG4Bkvs/EMKWe57pla7vLS6QXRvjrIZarjB4fOr3vPGC+LeUqudw1DC4eOyFPte
         tcI3bRBPeQpnmaSGCsvijrUxVGbwjGwnlTtO6mx2m+QhC9eIIIsyxcpF9OkXjR5XpYjd
         V5ypBgeWwCKLSktXtOhxohCQcXBTsS99ElAFokMqamscsK69byKNqGnGqjoJcgFYTWAJ
         kRP1QKqExEyAPl838TJl7QK5btVDxA3qLSTFzf0JuvItKPIx5nlABb6jKcDpchBYka2a
         2adQ==
X-Gm-Message-State: AOJu0YwZDqFmcSIn1AtdNsmevy1Jdclf15bNYI4tgF503Xb7yZ7pAkh5
	XX//qisdj8XbYLMsKaJebPFaxdmLL/NaMVgLJOHRYUGAb3ueDm6SPMmM
X-Gm-Gg: ASbGnctVdOUHVHCPf6TBNizNSLe0375B207UsOk+EkJe34AcnZ94+ViFr+BzLmNu7zD
	JB7G8GjYeanEtWERIeWHGas5ykcsQ57V3JDvuUI3nI29bpABoZzEz198q8rBHYeh3PHfFf4G4Th
	6GsNV4+P5fJlDdgqO8rJ175DQlwHvTluB0IPTdLWz7xydJBLjpYxKvBAXIUmvBAoTEeU2HWRH4z
	k6xxRVAaeisAhXCL7cT5GHmtZpPCtCmkIEVVqQpULZGddxcLVcRMCabiIZIYnePl67dnX4Ni87b
	x+iuQRAHGIb6iiCfC0lNAlAcXg+vB4sFFHdV7nMkQfYOlyYud6+qezc=
X-Google-Smtp-Source: AGHT+IG74A9poziDvr1C9dvIXzsl2nw/o6JuLKm+RFrSDBP6xC1Ceh1Mtpyg3NMN2DWjWBJuCGJiGw==
X-Received: by 2002:a05:6a20:6f07:b0:218:2b6e:711f with SMTP id adf61e73a8af0-218ccb1fd7amr3362443637.14.1748381216521;
        Tue, 27 May 2025 14:26:56 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::7:461c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2cb50c9935sm71015a12.18.2025.05.27.14.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:26:56 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,  andrii@kernel.org,  daniel@iogearbox.net,
  martin.lau@linux.dev,  kernel-team@fb.com,  yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 00/11] bpf: propagate read/precision marks
 over state graph backedges
In-Reply-To: <20250524191932.389444-1-eddyz87@gmail.com> (Eduard Zingerman's
	message of "Sat, 24 May 2025 12:19:21 -0700")
References: <20250524191932.389444-1-eddyz87@gmail.com>
Date: Tue, 27 May 2025 14:26:54 -0700
Message-ID: <m2o6vd7nj5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

This now conflicts with the following commit:
e2d2115e56c4 ("bpf: Do not include stack ptr register in precision backtracking bookkeeping")

I'll wait for comments a bit more before posting v2 is conflict resolved.

[...]

