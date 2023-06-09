Return-Path: <bpf+bounces-2210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17E7290E9
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 09:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770D628181C
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7058F59;
	Fri,  9 Jun 2023 07:26:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23A463D6
	for <bpf@vger.kernel.org>; Fri,  9 Jun 2023 07:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51386C433D2;
	Fri,  9 Jun 2023 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686295568;
	bh=NlICh2LYArFyyDIk04t30ruq6pjEc3ONIT3pYa7ypiE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ANDEU18q7UCQthZ5DblcmPaYvHtJjKsbfDRJ4Gr6/G31wRvhwnoTLJzzIWxl47r/j
	 kPn7htSOVJOBpOc4yiPiPcC8y4Q1CzBD0AaOE2hXSaRHsgB57mkjrZeokIl85SQAPu
	 AVPSwu6LVC1i4P0X/gbbbWPBISznHGxT3Sfs33t4JTKau50ZW8ioGwdn0wS50X2zum
	 AoWJwi/GMjuhQz+Un/SxO8pBGVXo5qv8vv3P60BVSeP1MXYUa36A3vdiui7eDYoR3o
	 zcKO5Tgp+I8IHqZux4ubthpYpn1E4wZPqD21HDlAG4tNTTWiTE8/GVZNXiep+9Hxkf
	 qVVYEE3872LqA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Jun 2023 10:26:00 +0300
Message-Id: <CT7XVY50ISCC.1I60H7POH94ES@suppilovahvero>
Cc: <miklos@szeredi.hu>, <linux-unionfs@vger.kernel.org>,
 <kamatam@amazon.com>, <yoonjaeh@amazon.com>, <zohar@linux.ibm.com>,
 <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
 <serge@hallyn.com>, <stephen.smalley.work@gmail.com>,
 <eparis@parisplace.org>, <casey@schaufler-ca.com>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
 <bpf@vger.kernel.org>, <kpsingh@kernel.org>, <keescook@chromium.org>,
 <nicolas.bouchinet@clip-os.org>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, "Mengchi Cheng"
 <mengcc@amazon.com>
X-Mailer: aerc 0.14.0
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
 <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
 <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
In-Reply-To: <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>

On Mon Jun 5, 2023 at 11:38 AM EEST, Roberto Sassu wrote:
> On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > With the newly added ability of LSMs to supply multiple xattrs, set
> > SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiat=
e().

nit: TRANSMUTE

Sorry, just hit into my eye. I skimmed it because I implemented original
feature :-)

BR, Jarkko


