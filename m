Return-Path: <bpf+bounces-4760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 010AE74EF84
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F2E1C20E4F
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F418B13;
	Tue, 11 Jul 2023 12:54:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4F18C02
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 12:54:52 +0000 (UTC)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4281BC6
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 05:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689080023; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=EJILvpRVvbBJP9EAKQdK4E6JyyamRdFDq619/4Y5S8ziyojRdBkBghVyVZAOP7vG/sg8K2qkIbxy4plIwAAV3Qs+Lb0K3c5OADwfYRHuLy2aF2dRt1zAxGNn0Ttow7s+PnxDh0xM/QrhSlDnqOCA4WqpsLi17KBOgyBpkASwo4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1689080023; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=sDRZhfJtZM6SMeCjTiady4Zm+GK6pjYgzZcKKqyOVl8=; 
	b=KUNCdnGDnhnDdDvrr7DDzUrbM/O0W1OsOIfCgfr0dkYjOxFVrU8q/SW0xoEXbsEFBANi6faK8IH5fISnkkVGa1XOrXuQOmjmv0YnzaG0sSZz4rLDYS1juD5DFLmkbL+zv5Jw8if0rfg8p+2IHJiab4anpEKev39Q3gNStoi5jVM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=sanganaka@siddh.me;
	dmarc=pass header.from=<sanganaka@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689080023;
	s=zmail; d=siddh.me; i=sanganaka@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sDRZhfJtZM6SMeCjTiady4Zm+GK6pjYgzZcKKqyOVl8=;
	b=uB70xTuUcHRlZ4P8LGGK71KxvRCMAiqyPxJ6GchJewl0/SZPcaYz1K+kkMVmcBS/
	ffz5J1fhos3oDtk5aIVg4vcj5Ggu/ld1G9Ab5FyLi9yjNPB656gvMRfDgvWRNu9iGzx
	pCjKdPd6/WgPHzwDjrwwzqybFlCNKWxJatxrsGq8=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 168907999102016.22711675023993; Tue, 11 Jul 2023 18:23:11 +0530 (IST)
Date: Tue, 11 Jul 2023 18:23:10 +0530
From: Siddh Raman Pant <sanganaka@siddh.me>
To: "Anh Tuan Phan" <tuananhlfc@gmail.com>
Cc: "Khalid Masum" <khalid.masum.92@gmail.com>,
	"daniel" <daniel@iogearbox.net>,
	"linux-kernel-mentees" <linux-kernel-mentees@lists.linuxfoundation.org>,
	"andrii" <andrii@kernel.org>, "ast" <ast@kernel.org>,
	"Stanislav Fomichev" <sdf@google.com>, "bpf" <bpf@vger.kernel.org>,
	"martin.lau" <martin.lau@linux.dev>
Message-ID: <18945034ac9.b8dab3f468630.3272096982280629892@siddh.me>
In-Reply-To: <4bf6475b-6688-1b6d-0db1-b0f15d2e1b3d@gmail.com>
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com>
 <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com>
 <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
 <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
 <1893b4bf70a.2c44c261262941.883099013045252156@siddh.me> <4bf6475b-6688-1b6d-0db1-b0f15d2e1b3d@gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 10 Jul 2023 18:33:23 +0530, Anh Tuan Phan wrote:
> Thank you! Will send a new version accordingly. But I'd like to admit
> that the v2 in this patch's title is a mistake. This should be v1 so
> I'll send a v2 patch for this discussion.

Well, I'd say you should still post a "v3", since inboxes of the
maintainers already have this email. Also, you posted two versions
of the patch here anyways, so v3 is correct.

Thanks,
Siddh

