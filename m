Return-Path: <bpf+bounces-15222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49AE7EEC7B
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 08:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8421F255D3
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 07:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF1DDB6;
	Fri, 17 Nov 2023 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSqStNsR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A84194;
	Thu, 16 Nov 2023 23:09:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc34c3420bso15078725ad.3;
        Thu, 16 Nov 2023 23:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700204953; x=1700809753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKGrB53cKKY0Owh0a3XvEKXkqzVrBqUCTPJE4dZj0yw=;
        b=MSqStNsR9OGuRwnx+vkeGmhTNUHRLp1xe3doP8S6nQtExpgFpWv2meHAGtGlrBxkuA
         GUlo5gKoSJSIu66+flxyLg0B9Zxur7j87Vz24uEOYiYEOz2NiMdECwAYM6Aq9rwiM6E0
         lRhMxIePX6ZMvN5NsjgN3hdJIA6ax3jg4jocOqFDPo0eb0zba5R2l+2asG8+8I5Ulh8w
         Ia+Qih6TnI6Fb2Z0TaBSGHkSYpDPC7Gl0ioqBQTVaYYA+C+/zFM16EDIdA/DayKQrbEB
         Q12wcAVpWkK4mP88+PjUBqefpZ8NSxHe8RAlVJuGqLRfGz4Dlu83M+wxSoWCnzSEeYEV
         huGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700204953; x=1700809753;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oKGrB53cKKY0Owh0a3XvEKXkqzVrBqUCTPJE4dZj0yw=;
        b=sMYtQ2PHpvO2BiPmZzttUPMkmdLLsAINAHpx0WCukRyHVfHY4psr7TJ3h1B4wHQUTH
         fKeRdow5Iqp3r+9Uve066x2PMDQJYYS+97koNnXxd6ioY/MOGRSGuf2jX0ZCm6qhbNQe
         zyk0hcvqVgl3cP/CA/XT5ykavqXKr+gZiMBcekmfQTzpA5kvArl98dFT/28YRDC5g4T1
         LUNylqgGBDlU+2WwpAc1yOuwnRxANSlYfj/2f2hVJEKvlh6EpofbqtC7ESDmItfbLnkk
         uMqmO7oRiEJ8DepU/r4Y2E5kGRmpMZ0tOucz+ZXWLShnjoS1h5z5LqoqqK2nR+4hbNU5
         tbKA==
X-Gm-Message-State: AOJu0Yy5TbuHhkPnU5CaQvIVSCP6AEVWoe7c78Y8V7O/Ye0jkSdxkpuO
	Cexe72kM/4hR5GpFajjnkeI=
X-Google-Smtp-Source: AGHT+IHUP9H2HU25w7abrLgLF04fFn3SPDzr6faUfmJDYOl+TgAZp6hmU/YvbWT3o+QdiKsh2vE+CA==
X-Received: by 2002:a17:902:8542:b0:1c3:1f0c:fb82 with SMTP id d2-20020a170902854200b001c31f0cfb82mr9176199plo.41.1700204952839;
        Thu, 16 Nov 2023 23:09:12 -0800 (PST)
Received: from localhost ([2605:59c8:148:ba10:377e:7905:3027:d8fd])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001b8b2a6c4a4sm738973plf.172.2023.11.16.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 23:09:12 -0800 (PST)
Date: Thu, 16 Nov 2023 23:09:10 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 daniel@iogearbox.net, 
 bpf@vger.kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 mattyk@nvidia.com
Message-ID: <65571196cff83_55d7320865@john.notmuch>
In-Reply-To: <20231116145948.203001-14-jhs@mojatatu.com>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-14-jhs@mojatatu.com>
Subject: RE: [PATCH net-next v8 13/15] p4tc: add set of P4TC table kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jamal Hadi Salim wrote:
> We add an initial set of kfuncs to allow interactions from eBPF programs
> to the P4TC domain.
>

If you just use bpf maps then you get all the bpf map type for
free and you get the bpf_map_* ops from BPF side.

I don't see any use for this duplication.

> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
> program installed in TC. To find the table entry we take in an skb, the
> pipeline ID, the table ID, a key and a key size.
> We use the skb to get the network namespace structure where all the
> pipelines are stored. After that we use the pipeline ID and the table
> ID, to find the table. We then use the key to search for the entry.
> We return an entry on success and NULL on failure.
> 
> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
> program installed in XDP. To find the table entry we take in an xdp_md,
> the pipeline ID, the table ID, a key and a key size.
> We use struct xdp_md to get the network namespace structure where all
> the pipelines are stored. After that we use the pipeline ID and the table
> ID, to find the table. We then use the key to search for the entry.
> We return an entry on success and NULL on failure.
> 
> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
> program installed in TC. To create the table entry we take an skb, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
> program installed in XDP. To create the table entry we take an xdp_md, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> First does a lookup using the passed key and upon a miss will add the entry
> to the table.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> First does a lookup using the passed key and upon a miss will add the entry
> to the table.
> We return 0 on success and a negative errno on failure
> 
> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
> program installed in TC. To update the table entry we take an skb, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
> program installed in XDP. To update the table entry we take an xdp_md, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
> program installed in TC. To delete the table entry we take an skb, the
> pipeline ID, the table ID, a key and a key size.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
> program installed in XDP. To delete the table entry we take an xdp_md, the
> pipeline ID, the table ID, a key and a key size.
> We return 0 on success and a negative errno on failure
> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---

