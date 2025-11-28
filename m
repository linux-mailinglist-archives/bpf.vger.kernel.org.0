Return-Path: <bpf+bounces-75712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13331C92272
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09FA4343878
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C27332E748;
	Fri, 28 Nov 2025 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPX//QtM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243132B9A9
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337108; cv=none; b=maSgJ5fV7807wwgDExLzzYun2OEsFVCEtDBjVUYqQmFCOHpuPP5vF4C/dfsDMPPI63Wr+uqjiPvOOVH/Dr4LzH1aT3RB1pMeEhLdQRh2dmGMB+OwWOZGnq6KEuEpoGETfZJBoptPN5eNo9iBjenISzXahiAzTei7ZH5zHN8T0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337108; c=relaxed/simple;
	bh=9Bz3iHL0GEwZT6cEvu2wIvJWs5QIKjgMMa/gzhHcFR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QgQrELNy3ILJRZS6AYAJlbZuQWmrO2D6LPHO6Y1WBDRVAjeSb4V73UOBIav86LIH0WPrDMBvVEvBmLqxWhzohLEMgcYZ2lkh5KTUAC8zXP0t1z17HVe/9r6dJCbOMmMhAJJhbSsGMZPf5yXY2grVQhjOUnLZKdrWc9dEzTTZZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPX//QtM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764337105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0Dso5+9f+79YJFdxfA0L+riU15R66TbnRBDWdbELo6U=;
	b=EPX//QtMDWpTb+b29PmW5oIUwLEISiJ4sKoX5WQNsj0RnMK4CooQ4uzGzmbQWgLTI7Vk2f
	ZgtAamr1EqNBa5pZ7ZHcOw2BEDiRC5tzWlY7IAWUYL2MZmYcI7cJdBDr7Zy2hb5Tn5L322
	xdGqb+9aclaJ1Jq6gYPh0ZKZ4PljhZI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-k87frsTQMKaJiWOa7XcPlQ-1; Fri,
 28 Nov 2025 08:38:21 -0500
X-MC-Unique: k87frsTQMKaJiWOa7XcPlQ-1
X-Mimecast-MFC-AGG-ID: k87frsTQMKaJiWOa7XcPlQ_1764337100
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6740D180123B;
	Fri, 28 Nov 2025 13:38:20 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.2.16.49])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7B91800451;
	Fri, 28 Nov 2025 13:38:18 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: bpf@vger.kernel.org,  andrii@kernel.org,  ast@kernel.org,
  daniel@iogearbox.net,  netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] tools/lib/bpf: fix -Wdiscarded-qualifiers
 under C23
In-Reply-To: <1531b195c4cb7af96304341e7cbcaf7aba78e4b3.1764334686.git.mikhail.v.gavrilov@gmail.com>
	(Mikhail Gavrilov's message of "Fri, 28 Nov 2025 18:26:19 +0500")
References: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
	<1531b195c4cb7af96304341e7cbcaf7aba78e4b3.1764334686.git.mikhail.v.gavrilov@gmail.com>
Date: Fri, 28 Nov 2025 14:38:15 +0100
Message-ID: <lhufr9y6zw8.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Mikhail Gavrilov:

> - Use explicit casts instead of changing variable types to const char *,
>   because the variables are already declared as char * earlier in the
>   functions and used in contexts requiring mutability.
>   This is common practice in the kernel when full const-correctness
>   cannot be preserved without major refactoring.

What kind of mutability is this about?  Obviously char *const won't
work, but const char * seems to be fine for these variables?

Thanks,
Florian


