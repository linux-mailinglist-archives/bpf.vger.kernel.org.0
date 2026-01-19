Return-Path: <bpf+bounces-79397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD7D39C21
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD62D3009C02
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8421CC4F;
	Mon, 19 Jan 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXLVBf6Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F71F4CBB
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787193; cv=none; b=epHjcGYc/gtlCkVzY5qhgLRZ1ZT9HRH7hRRUcumDCNVaf1Yf3hWu9/CFTULly8OGUvrAPjhe65mTfKduVwOLKuZiffs5MuS/vdulqtiq6jk+GPoyPV3ZGxSvKzo/Gwjkqg4U5P009ig+KxdTYi/vXP1758G7o9YnAhr4Cv2UrCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787193; c=relaxed/simple;
	bh=9lwQnZfXYoCMJq9YoeDIddxP7JrrS9jy7ARcqG3rVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQqXLrqLA3F0TZiDKn4iRoUcrF3koqPYGOnRmjl4SeNGmBU2e/Z5BU5H8f2pCy6a8mdFn6Hnjfa/KJYz5ntj4G4e7eCfIiDszEJrAc3gm+/WhhCqg0X7W0xtgu25OFswF34o574NMPGC2VkS6CL7hLZKbgGixArTwKQIMqxcUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXLVBf6Y; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6ae4c2012so2773224eec.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787191; x=1769391991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iehqn6j4OZ3OekVxEIvyv834zGJxoi7hUEw8UUQb3oQ=;
        b=LXLVBf6YYOVBb2EJvynvCsvocSPcUbJucbnKSvRjhXxVQ+wq6VqpwbTllrHU3z+59S
         E+RG93b1OR77EzlJ3fJa3dgpK2LHZQx0aWaAu0fLd6g+hsRs1mUcCWoDH3iEXfXoxyHv
         0OMGqq+6m+56kpdbSQzLtP/kTf5900RV4XSlSkW2WUKQTUK1g9hWs3d2yDD7s/hCdMq3
         ndLE9U9ATImtTyOvLEqIBREbV/BApQQ/8sirBRgdxHLQWx2dAllmcPJC2nRzZSJOyO7o
         vyhlmuLuN9fbOIayQlr/+VDGoyH4E56ctxFZuoTMk84NSmIHjh4CpZ3qtIW5OjvDa9gG
         El3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787191; x=1769391991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iehqn6j4OZ3OekVxEIvyv834zGJxoi7hUEw8UUQb3oQ=;
        b=MIYTrK+83HNKks7QHzri8pXUm4yBMK6dMWUTWA71yLxpc5fhDvEpB6dQBz3glIFfuL
         63wK0gTtKFHkn7PRC9GNptGmkOwO0+QyiLWOa4+IeFaMLQTjxwrIMpoNod6iBVSBpTqJ
         Wm5vVGS/MkkOmHMOpgIrrzWACN/OlRmBL3eQ9havBTXPxZkw+ivZNgdQCGtJhuXf804+
         451/0CzJbLeeRaxEBvGFj1TBevezx09RBzmVKQjjLN/Oa0R+DzrMfyrksQ8m2A3SAA0w
         zx1TxPU4wWm89tcBmxEaMKKjTk8FZwwgdq174D7fce0GrYbbIQdy1v56XOoObgDzHOMf
         i7/w==
X-Forwarded-Encrypted: i=1; AJvYcCWs+rhlAcOT8tZbyr5dYYDYD9qrjak8ujHFAA+7KC9zfP8iDMOnkl/GtwX4+YViZ7+LC68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+qGOVMhpEORCzHMnIqZlQrcCfb/yTCpZASAo1VHpeDM0skss8
	sNR9YyG5Q9yksRFSa9bnNr7Iaau1KIwiAUKYbSOCw4Gvdykp6C+Iedk=
X-Gm-Gg: AY/fxX5yWcCX8d4E/kBv1qHJ1O7OSPkbPrDxP9FKiXmEAe3KpyLgUWj42lQzDa9hwZS
	Iz0CqaMDkxsp0gyaiprdkwhW/INCQRHGB7lTPnIxfeUnCk/RFs7Vp/X3ExbzYmYjBE1Uzsk1HIN
	cVirlgW+yxUrJarOE7jMUFfzJSX1RTVuR7gMj9SscUFQ6r6VFbt51C9XuDHseUiXkXT4pWh7bHy
	ro9ikDmiEU0b1cCd5dIM27o5Fiie1g/JeRrKdAWveL/H7pEwce7caNAZ4eOL5n7dZI5HcjUvYsx
	Z3EY0tYrSrIOecDTkAGXsccBMPKr5SxexJyXGljv7Tbk2u5mROKX/oVWw7/5CQi3uNnso3++JEi
	P0SDfvQA2TCYf8TVlfyWNn03JJjYbzu3+mJLB62cxvAN5nILh53UrDlLf8vQQsUsQEGFxRQ8d9+
	p2mGhgSEHK0C7ooOBdHlyGJHLFV7wBclHwQiHxKpd7Nx6plB/b7h9mckUSjqApQh8y+cOMrE9xW
	lHbug==
X-Received: by 2002:a05:7300:a98a:b0:2ac:196:c0d1 with SMTP id 5a478bee46e88-2b6b40f3548mr8770944eec.32.1768787189383;
        Sun, 18 Jan 2026 17:46:29 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3503a30sm12482735eec.13.2026.01.18.17.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:46:29 -0800 (PST)
Date: Sun, 18 Jan 2026 17:46:28 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 16/16] selftests/net: Add netkit container
 tests
Message-ID: <aW2M9HHX0i_T9JPk@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-17-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-17-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

