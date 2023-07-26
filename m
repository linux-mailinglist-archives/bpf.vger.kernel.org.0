Return-Path: <bpf+bounces-5932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5DE763482
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B25281D95
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1459CA74;
	Wed, 26 Jul 2023 11:07:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EFDCA40
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:07:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8065CAC
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690369631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RhAASZDa4qR7wxJ12uUhhLwWeU47PEkDN4ojyr2iK0=;
	b=F6+ynRoso5YDQS0o3hbqxegp6UQXHEL9qYAvSQyVJFtgGJD7ZIeVrZoAfge91yXUOrESgq
	YtiA+pZBdYiO6KQQJxugbz5Usv8hKfSdLmTG4B4zLVRbyu+D+BfVKqSGfqzIixm60enxTf
	KAm3M0Tyk4kMopRbNQ0W65pmanETyq0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-aGNt06TMOumnMW_nNUpsSA-1; Wed, 26 Jul 2023 07:07:10 -0400
X-MC-Unique: aGNt06TMOumnMW_nNUpsSA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-40631b647cfso9790321cf.1
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 04:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690369630; x=1690974430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RhAASZDa4qR7wxJ12uUhhLwWeU47PEkDN4ojyr2iK0=;
        b=eiLXLkF06JWfybUZqhd65iImseTYaFJDjKdTksi/tUaj8INT2GrxKmhHxnESfFmYeG
         ED30Y8uMxyRVMkRwqWNInJDALbUgOFa52WY24lrau03JqumQ+QpWOBkYujcLeCF+NrkN
         +KkLZDBageRayHC+Qqsqnh2uyFICnyst8W2pUgy20/I6RvWzPVWOSKa4CtA5z0D3omtM
         CUwJ6JuGdw+z5HrQMaR/VGxgWr8K5TpC6Jkir7BrSa9fVVP4PRl/HIl0mmLqQYY28Re8
         Dky2kpwFmhnnHfBd5CAC5QOEKQEJJ769Va/OR8snoib2U6jn6TGVsQE39MDO/vOUr5hV
         Trng==
X-Gm-Message-State: ABy/qLYMHZgyA3hhd8dkrwzhONw+UwSKsWCPjoLtvs/Ts6sqxKzBYVKx
	EeUNinS4OHQlmaj+FhTjmBRt1R87LH4uVd2hCTh/s9+H6m9+CXCmrWQ4FeBzZKVZ6+idu+muCL1
	/9qA8ryR5KBqn
X-Received: by 2002:a05:620a:4007:b0:763:a1d3:196d with SMTP id h7-20020a05620a400700b00763a1d3196dmr2275646qko.0.1690369629874;
        Wed, 26 Jul 2023 04:07:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG7QqDnzpUB/dwYHGsT9KH02d9NGuFZpNXp+ZhNitR8Wn10FxTtx+Vjhi+ZWJYa1GU4+YNjiw==
X-Received: by 2002:a05:620a:4007:b0:763:a1d3:196d with SMTP id h7-20020a05620a400700b00763a1d3196dmr2275618qko.0.1690369629594;
        Wed, 26 Jul 2023 04:07:09 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id dc8-20020a05620a520800b00767c76b2c38sm4268489qkb.83.2023.07.26.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 04:07:09 -0700 (PDT)
Message-ID: <a9b4571021004affc10cb5e01a985636bd3e71f1.camel@redhat.com>
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
From: Paolo Abeni <pabeni@redhat.com>
To: Paul Moore <paul@paul-moore.com>, KP Singh <kpsingh@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 linux-security-module@vger.kernel.org,  bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com, 
 renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
 revest@chromium.org
Date: Wed, 26 Jul 2023 13:07:05 +0200
In-Reply-To: <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
References: <20230119231033.1307221-1-kpsingh@kernel.org>
	 <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
	 <63e525a8.170a0220.e8217.2fdb@mx.google.com>
	 <CAHC9VhTCiCNjfQBZOq2DM7QteeiE1eRBxW77eVguj4=y7kS+eQ@mail.gmail.com>
	 <CACYkzJ4w3BKNaogHdgW8AKmS2O+wJuVZSpCVVTCKj5j5PPK-Vg@mail.gmail.com>
	 <CAHC9VhSqGtZFXn-HW5pfUub4TmU7cqFWWKekL1M+Ko+f5qgi1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

On Tue, 2023-06-20 at 19:40 -0400, Paul Moore wrote:
> On Tue, Jun 13, 2023 at 6:03=E2=80=AFPM KP Singh <kpsingh@kernel.org> wro=
te:
> > I tried proposing an idea in
> > https://patchwork.kernel.org/project/netdevbpf/patch/20220609234601.202=
6362-1-kpsingh@kernel.org/
> >  as an LSM_HOOK_NO_EFFECT but that did not seemed to have stuck.
>=20
> It looks like this was posted about a month before I became
> responsible for the LSM layer as a whole, and likely was lost (at
> least on the LSM side of things) as a result.
>=20
> I would much rather see a standalone fix to address the unintended LSM
> interactions, then the static call performance improvements in a
> separate patchset.

Please allow me to revive this old thread. I learned about this effort
only recently and I'm interested into it.

Looking at patch 4/4 from this series, it *think* it's doable to
extract it from the series and make it work standalone. If so, would
that approach be ok from a LSM point of view?

One thing that I personally don't understand in said patch is how the
'__ro_after_init' annotation for the bpf_lsm_hooks fits the run-time
'default_state' changes?!?

Cheers,

Paolo


