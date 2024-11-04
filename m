Return-Path: <bpf+bounces-43864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B89BAAAE
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 03:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4491C212E7
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBC1632C5;
	Mon,  4 Nov 2024 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpCnwXt1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109733F6;
	Mon,  4 Nov 2024 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685759; cv=none; b=qehR5hMZF2+t2SIFy7qAHtzaOpTob9ElE83SjGsItJlumWI/geDtGTeRZ5s6NxjgFzJ3ViRSONjZpoAida7PeuRm8kh/l3Zp2RgpoUj58bLcVEwzqz0DpztlTbu8pHj+tGCkSypFu+JsFqlzLfAScp6UO6FYobUaGkQLMG6wcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685759; c=relaxed/simple;
	bh=Vlf3tX58PlgJGwd0FWGFhEROPkOfNoB19VMjuTM1rk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7V5ToatRpcV0dWJtJTW8NxHBSzIX1KMj5ftbtTt7NsmmF/ptH9N3jVePF61VDgKY8ZZERZ/+Gp09OzEnPms8D2lskml2qVlDty3FWE6RquwU+XZFOM8Q6zgQ8zILP7yynitW2nvjz8icQHfHi1FUhTFeDSMHkWUxsdfuA/u0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpCnwXt1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2113da91b53so5127125ad.3;
        Sun, 03 Nov 2024 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730685757; x=1731290557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vlf3tX58PlgJGwd0FWGFhEROPkOfNoB19VMjuTM1rk8=;
        b=WpCnwXt1xHX+gqXL4tTk6mtmO0o6YiUU/6ZXQGvi4bknabBmguAZcfWeSQTajYlEjx
         JkPIeYVBb192t7Ts2GPTANZJ0T/JsU/WeDReHrb7zamPUFkDm2uBj+D0qDfubkbvwc7U
         nrcfO3bj63V15yJAe+kXMLwdZ9AGnfddzNDvMEIIuYrpsaM0c2OMabeVbF94kqbVbBQO
         CfV42Vp6JhW0jKqxOlfbKXz9omAkicy4j4VKxlqIjd2+nYNN5pFPXCAWZKwRWYdlMk49
         DwRRbDz+Y9unVOUdJQ67BNETf7nPbcdqxWKkeqj9vYpiOJNcfjExcs4hI8AAOkZg1Eo7
         af4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730685757; x=1731290557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlf3tX58PlgJGwd0FWGFhEROPkOfNoB19VMjuTM1rk8=;
        b=Z0NpqUxjXGgOae3ewhO4t38YqbS2s7VHJZLeL3XKlGSV59kCpdqqNlJu+ZzhXpd4aE
         a44ZSjhGWQP6HS2zLB4ugwzHFgLdjwqpJHJG91mjsV7Ya38h6bFo6F050sPaRAmLIye1
         Xj9Ad59hrRnOL8QPWbzrBqunrD38RxbHXPpKSVVPD44N0dY5+u3dYYIkxDDL7KmIOqmW
         7emcRULDo1p1tNzoKYSUNSObqvrWWIgzACvQIWPvNBT4CrQHKUppP5+rwhz+LUKzSRYD
         BkckKpRPAXw/GHnlcaarkjcUitV3VI6dPK7C7VkciJYNTJ3fktWt3G2EWnRyRAzJ79dw
         SVNg==
X-Forwarded-Encrypted: i=1; AJvYcCU4CNIUL2aYPQ1HYgZ2VUPbC/eMPdpZ8tHCrh1spI7GA6IfBDyeFBKVqyc+JrvUYw17EzkWWzGU0rvesJix@vger.kernel.org, AJvYcCWj0WnpDK0CDc3zVs2BMQIn/rq/8cwzWfujBWWCuaODUEuS/sIpJ76lzoxqIqahNFqrBE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyrk7BfslbL3Vgl+56zYfdmp7j6nm15cRSVK/ZPSyOskisecpt
	oPh6rbKyCIOgCEdYiJpf2ZrhyEd7Ry9uoNKddPvItLGCPKSCbDEc
X-Google-Smtp-Source: AGHT+IHmnJIhfE2wNFtFx7dCBi79OOZ755sG8tQ2pQaY9t6b0rtSlaQeQye5un9/ZB23EXef4Muxdw==
X-Received: by 2002:a17:902:eb81:b0:20c:e65c:8c81 with SMTP id d9443c01a7336-210c68c9527mr439693845ad.20.1730685756987;
        Sun, 03 Nov 2024 18:02:36 -0800 (PST)
Received: from byeonguk.jeong ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ee490sm52033375ad.18.2024.11.03.18.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 18:02:36 -0800 (PST)
Date: Mon, 4 Nov 2024 11:02:30 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
Message-ID: <ZygrNkfNVUmc74ZG@byeonguk.jeong>
References: <ZycSXwjH4UTvx-Cn@ub22>
 <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925cb852-df24-81b6-318a-ee6a628d43c7@huaweicloud.com>

Okay, then do I need to resend this patch or it would be accepted anyway?

