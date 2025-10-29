Return-Path: <bpf+bounces-72691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2E9C18CD6
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 08:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12F33BF844
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95973310630;
	Wed, 29 Oct 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR1w2pes"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6C30F959
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724357; cv=none; b=DaNroHxXphgHHj/smG4MIQ+uBCqT5j/EikOm1NVqkLRbGwi3HjaaovCIz8hm2h+F1BPS7YwuIl6qWAtylXleoQF+8bO6egEKzGfQ3bDVI+aiJQAA1XFs71GHP7lwRgPHIMsXtj1X2dldtgRMjM0dTTVdM2usuH1zJXxTlhTbRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724357; c=relaxed/simple;
	bh=d+3F8ifPRHXFbWiCU0mXGYHLj7wBVR6XNBd6P3QTX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjlR+v6fcFQXNtmtR1qDr8zYNRrq5gbMq5IUfu4RupS4keNVV8SO5so0pwiVHytm9h8NvT7zBVDWb7yYOshlEXDhOjN0cQhyJiGLoKQK3Ihj6uQKvWAFfRvh3JHuPpH1IV5UwYyNmDvdu3P76wX906TTcY9vlGU5OIwuJ25q98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR1w2pes; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so1306628766b.0
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 00:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761724354; x=1762329154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=KR1w2pesO82Pos8i6pVakPIU2Ju7r+z/lQWWaNwG3VE1qXU+DlQjKvSevc7krHnlB2
         Z6Y8pM0EjcVcuYLttLENggrIYO+50ULTHbX/fBh0zvmVIdhbs+BRq0foCqIzwAg/hk/C
         vMR6lYkATzJD6WMxgUXtPSXrweyKTDtzj/E3/kAS5OL9ORjCnVSW4Za94+FESuKtiILG
         dD9QnX8VQDJSL/j15xbyIw62HH5kWs1NLUk0jxyUtMdAR33G/iZe8YrXBcERUs2pDtWT
         CuBraA6gRrDIyeoprzOXcGqDXuTtj0pHU58AeesgJE7gGIhOb743FxAsXh4VuqIcy9Vh
         hX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724354; x=1762329154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkFkfoX1+/bTv24rgjMgjWItS99qE5Oq3y2IeAjCaqE=;
        b=c9iDJiWWI+Xq5apsgB8mvK4XiJkimGfkTPSmRUeomZvKX/waN6xAOqhYmnICc+kHNH
         zVu8FKhCMxfL2DwZ/+cCIp6uKVDYFRjXPyI736hdfwNMvLhfAH/de7LC8iLw/nrNHKXu
         K9H/RJnnV0rHnRWlXAT5RP+MWTH+2d2GV+iVsa0uHzvieSV7cCrUsb8+FiE8cjIFtmWL
         UyTaGF4DR5CcLRwYmfGDSCvCb+zf/r6AXb5i3fIjRpKLopPwzESZoPH57Y5jnKXWbOUJ
         NmTSdX2FmVXcO6SNyZtTQbx65tJwkRvWMsZBuHdXJXOCawe/Jhi5NCwe7PtcsmrIf4aa
         CSfg==
X-Forwarded-Encrypted: i=1; AJvYcCUXQxOf4ruEtFfQYsf11qAlNlHDbumsLn/wjXnroApU/oS7nikZXKzyJUvbml7is+qrHtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cgl3ugwNxMGCbRu6/WGfuNIsHX9ulCdxwRRnvQxIH7hy9J6X
	u+N4foBjslm+zJT5aBvoewpjWMvZI9PsFpCmfem9sgzQ6oWteX55AQ/G
X-Gm-Gg: ASbGncsqyjSOOLTIzRZg0j0s4SqAzKnPHX1ukkgBTzu8KkdaXx282DGm+MOkhWg7FLQ
	09ZNLRPmac/SaemnfFuajWbUTAOEIS0Rg/vRg3Smofl1e2BB2KQPK4GJSk0JT/x1cTYAewreR7o
	lR5mlkh6M8GgyXgjBSO57oJy3qexC5qA/I60m0tLiuT1VwYWQtsysZfo3+1+lPIZgztfhQN0Osk
	KSWzpyaSn9wGUjG/6U1Kz+1RLCv5PjmHVRmKxEIZAXJICdiCMnesP8O0V16vDe57Ry6Vs+kIqYc
	SjlGMIhc3Au9WluUz0eh3jWfoVkOOyCnPRNWhQWT1p/gXc+ws4mMA7R7sfNwuIXMFaSd5MftCzN
	CSTgb+pUnwML4AoKBzRhvn5cGXOqnVOxnLpAZ0Johg3lvGnv7qK7nUTaRMw+goPS4g6bAy1zn0L
	rR
X-Google-Smtp-Source: AGHT+IHtSgmrBsC3MRR28mflYTkgpLevXtnHQXIDSUigDzjREnxXOwaBD8WEsWGS3KPcLidmHJbHaA==
X-Received: by 2002:a17:907:971f:b0:b5b:2c82:7dc6 with SMTP id a640c23a62f3a-b703d4f7df3mr180499066b.40.1761724353666;
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b6d85445d48sm1331864766b.65.2025.10.29.00.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 00:52:33 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	arnd@arndb.de,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jack@suse.cz,
	jannh@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@yhndnzj.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v3 17/70] nstree: add listns()
Date: Wed, 29 Oct 2025 10:52:26 +0300
Message-ID: <20251029075226.2330625-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-17-b6241981b72b@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian Brauner <brauner@kernel.org>:
> 2. Incomplete - misses inactive namespaces that aren't attached to any
>    running process but are kept alive by file descriptors, bind mounts,
>    or parent namespace references

I don't like word "inactive" here. As well as I understand, it is used in
a sense, which is different from later:

> (3) Visibility:
>     - Only "active" namespaces are listed

-- 
Askar Safin

