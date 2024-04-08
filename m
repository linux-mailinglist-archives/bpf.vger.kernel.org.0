Return-Path: <bpf+bounces-26214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A93A89CC5E
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 21:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD432850E6
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7A2145B08;
	Mon,  8 Apr 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/iXTebF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CC145326;
	Mon,  8 Apr 2024 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604284; cv=none; b=ac3xKlNrRGehl9v9EL19AG+bo103a/Y4fFI4aCtIzSa+n1QbeBygiY9BAxJNIwlJuGczpO7UINxFwL4zeVkc7+l53r1b84KkCz1foM3KFQv1Qax/5PnfUxfDAkWVH/hmus4tJpJX1WVl8pnMbShPLhw0mMMf1t5DKrhbR9rmyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604284; c=relaxed/simple;
	bh=0J+7qAnEN8ZwzMROKbQFT0jLGJ8mF4BEyGRW+5cjQhk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iwJg3zrXigfVae4bV9dUCbH7aAF8ft0fEMJtkuoONxbyl7HOrOxmYXZ861HUZRaM4nVyDGaJH06F70j0UMLVSlz6cBWdNQ7dnMhvYyS3ESe9D6ql6RnN6SzZ7Q8z56F78DTluyAKMNkvbt8eVMUKheR3kSLAZpde34YgGgJFeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/iXTebF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3242296a12.0;
        Mon, 08 Apr 2024 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712604282; x=1713209082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J+7qAnEN8ZwzMROKbQFT0jLGJ8mF4BEyGRW+5cjQhk=;
        b=b/iXTebFCZGzzDHUk8KS8mPDi3fA9FJiaI7pW/6mBISU0y1zv+gqx8VE9W+LYA1TXa
         OAK0GWnVw/XWbTdmFDoTMj9xRs7gjN6u2sbuoirfUAJZTEJeW0vLQm1oEZLdTam6sfob
         4Qgq6gsqY9qXgHSiK6zE+mxMj8rT3MvDTlgVqsXr10k4xZ6SMBk0tIKO6acLsBjL/yji
         Izw78Pru7HIu+588m+FSd9vRafhyA/rlUgLWnwnPSSENLGC+gn4M2IMtaeA+iBcNU0Ab
         1ZhM5V1xBoK+dc/vOPz33eHntZjDyJ/ApUIRCWyg+gBPsoaPvLJzEXM26pl+jbUbMo1p
         QoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712604282; x=1713209082;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0J+7qAnEN8ZwzMROKbQFT0jLGJ8mF4BEyGRW+5cjQhk=;
        b=E6KKPrqo5dOYQ5hjznkpiNYFfJqYEQOS/4ET6nZbZYNsn0+3xGmzn6d+73icCbAQId
         tvvUYY22Xd9WoytuEXDnlJBNIrmDSyZsaic/ETY267cxZhGov9XaH6CIkBWxjFmi3cUg
         RQ5BJhnTNKarQbHqx8PRUxuSMSIIDKU7DICmh5KHg9YBQ61gLk8amFdSN60KT2Ya4Aii
         KhQTSg/Oew6Rg124676QBA4Qs3meyWrnOuCsxJmmNs5mcGmgBTDigA1Xydo2270N5k8h
         dWwzqiwv4EvNp7ENjPYZGPUEvhHHATAciDTqEOqdlXx2Cqn2GOj80omfHL4NWOyFhUPI
         syuw==
X-Forwarded-Encrypted: i=1; AJvYcCWg6VwR/gIfDAzlwctNK1TWavzu3Hm4O6hnY9t+GOLMnED619FF0XbXVfp8yUXKEUfT6H9/iSP2nxz1W+eyrB5ReOGlamTsD3EPsgl4HeD8r8WFL7f5R6tCUa4C
X-Gm-Message-State: AOJu0YwgrkSXJG+jNPYFSsuQnzF5a8gTbG+abijPF70purOmEBUnrlHM
	b3+SsWsWtkxkYY5Dq13NLv4lady7RPCHfv8Vxk8qCQS5pslNwx40
X-Google-Smtp-Source: AGHT+IEgOGs4Jh3FPkMrr2e/Hk5j2J/vpqH+VlGG9k2//RkxTOK+FftQMv+1W/q5mj1EfOfvIzduUg==
X-Received: by 2002:a17:902:d2c8:b0:1e2:6b74:5941 with SMTP id n8-20020a170902d2c800b001e26b745941mr682365plc.2.1712604281814;
        Mon, 08 Apr 2024 12:24:41 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902e88b00b001e3e0968f8asm4912952plg.248.2024.04.08.12.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 12:24:41 -0700 (PDT)
Date: Mon, 08 Apr 2024 12:24:40 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, 
 anjali.singhai@intel.com, 
 namrata.limaye@intel.com, 
 tom@sipanda.io, 
 mleitner@redhat.com, 
 Mahesh.Shirshyad@amd.com, 
 Vipin.Jain@amd.com, 
 tomasz.osinski@intel.com, 
 jiri@resnulli.us, 
 xiyou.wangcong@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 vladbu@nvidia.com, 
 horms@kernel.org, 
 khalidm@nvidia.com, 
 toke@redhat.com, 
 martin.lau@linux.dev, 
 victor@mojatatu.com, 
 pctammela@mojatatu.com, 
 alexei.starovoitov@gmail.com, 
 bpf@vger.kernel.org
Message-ID: <661444789fccf_49a6208ec@john.notmuch>
In-Reply-To: <f27bfc4d-8985-6d3d-01f5-782ae1ccb9ee@iogearbox.net>
References: <20240408122000.449238-1-jhs@mojatatu.com>
 <20240408122000.449238-15-jhs@mojatatu.com>
 <f27bfc4d-8985-6d3d-01f5-782ae1ccb9ee@iogearbox.net>
Subject: Re: [PATCH net-next v15 14/15] p4tc: add set of P4TC table kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Borkmann wrote:
> On 4/8/24 2:19 PM, Jamal Hadi Salim wrote:
> > We add an initial set of kfuncs to allow interactions from eBPF progr=
ams
> > to the P4TC domain.
> > =

> > - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
> > program installed in TC. To find the table entry we take in an skb, t=
he
> > pipeline ID, the table ID, a key and a key size.
> > We use the skb to get the network namespace structure where all the
> > pipelines are stored. After that we use the pipeline ID and the table=

> > ID, to find the table. We then use the key to search for the entry.
> > We return an entry on success and NULL on failure.
> > =

> > - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
> > program installed in XDP. To find the table entry we take in an xdp_m=
d,
> > the pipeline ID, the table ID, a key and a key size.
> > We use struct xdp_md to get the network namespace structure where all=

> > the pipelines are stored. After that we use the pipeline ID and the t=
able
> > ID, to find the table. We then use the key to search for the entry.
> > We return an entry on success and NULL on failure.
> > =

> > - bpf_p4tc_entry_create: Used to create a table entry from a BPF
> > program installed in TC. To create the table entry we take an skb, th=
e
> > pipeline ID, the table ID, a key and its size, and an action which wi=
ll
> > be associated with the new entry.
> > We return 0 on success and a negative errno on failure
> > =

> > - xdp_p4tc_entry_create: Used to create a table entry from a BPF
> > program installed in XDP. To create the table entry we take an xdp_md=
, the
> > pipeline ID, the table ID, a key and its size, and an action which wi=
ll
> > be associated with the new entry.
> > We return 0 on success and a negative errno on failure
> > =

> > - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> > First does a lookup using the passed key and upon a miss will add the=
 entry
> > to the table.
> > We return 0 on success and a negative errno on failure
> > =

> > - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> > First does a lookup using the passed key and upon a miss will add the=
 entry
> > to the table.
> > We return 0 on success and a negative errno on failure
> > =

> > - bpf_p4tc_entry_update: Used to update a table entry from a BPF
> > program installed in TC. To update the table entry we take an skb, th=
e
> > pipeline ID, the table ID, a key and its size, and an action which wi=
ll
> > be associated with the new entry.
> > We return 0 on success and a negative errno on failure
> > =

> > - xdp_p4tc_entry_update: Used to update a table entry from a BPF
> > program installed in XDP. To update the table entry we take an xdp_md=
, the
> > pipeline ID, the table ID, a key and its size, and an action which wi=
ll
> > be associated with the new entry.
> > We return 0 on success and a negative errno on failure
> > =

> > - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
> > program installed in TC. To delete the table entry we take an skb, th=
e
> > pipeline ID, the table ID, a key and a key size.
> > We return 0 on success and a negative errno on failure
> > =

> > - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
> > program installed in XDP. To delete the table entry we take an xdp_md=
, the
> > pipeline ID, the table ID, a key and a key size.
> > We return 0 on success and a negative errno on failure
> > =

> > Note:
> > All P4 objects are owned and reside on the P4TC side. IOW, they are
> > controlled via TC netlink interfaces and their resources are managed
> > (created, updated, freed, etc) by the TC side. As an example, the str=
ucture
> > p4tc_table_entry_act is returned to the ebpf side on table lookup. On=
 the
> > TC side that struct is wrapped around p4tc_table_entry_act_bpf_kern.
> > A multitude of these structure p4tc_table_entry_act_bpf_kern are
> > preallocated (to match the P4 architecture, patch #9 describes some o=
f
> > the subtleties involved) by the P4TC control plane and put in a kerne=
l
> > pool. Their purpose is to hold the action parameters for either a tab=
le
> > entry, a global per-table "miss" and "hit" action, etc - which are
> > instantiated and updated via netlink per runtime requests. An instanc=
e of
> > the p4tc_table_entry_act_bpf_kern.p4tc_table_entry_act is returned
> > to ebpf when there is a un/successful table lookup depending on how t=
he
> > P4 program is written. When the table entry is deleted the instance o=
f
> > the struct p4tc_table_entry_act_bpf_kern is recycled to the pool to b=
e
> > reused for a future table entry. The only time the pool memory is rel=
eased
> > is when the pipeline is deleted.
> > =

> > Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> =

> Given the many reasons stated earlier & for the record:
> =

> Nacked-by: Daniel Borkmann <daniel@iogearbox.net>
> =


Same for me. For reasons already given tldr,

 . p4 can be done already in xdp/tc with p4c backend
 . not clear how hardware offload would be done
 . shimming control path through 'tc' seems unnecessary
 . related kfuncs duplicate map operations already there
 . disagree with pipeline design e.g. single xdp.o is optimal
 . keeping control path in userspace will be more flexible.

Nacked-by: John Fastabend <john.fastabend@gmail.com>


