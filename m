Return-Path: <bpf+bounces-41751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D399A82C
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330792833F6
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE5197A9F;
	Fri, 11 Oct 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D+aNsUu9"
X-Original-To: bpf@vger.kernel.org
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663B2E403
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661533; cv=none; b=GLywUZ/KRACEzLPPrwFa6LfV2DbkRzad+2SUZgY4aaGqSCgphsfF98Jl21lNWfnadZT0rnTFKbc+UR4wr3vYyk2LAmzDNTEtnc3ThgYmQvsRP9luaw4IJK7nZH1Ltqtc79wcJuaYEMfKQGexKlmuauMr+43diZWYCzU9vgOokMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661533; c=relaxed/simple;
	bh=ZZ67WxIVnB76P4GfmunoWfIO+zyCFe8qhuB0nefs8Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejHLVZ907f3dGT7sJvmMzMvlea0jGEM7LGFgAromwGwY6Pd3irTvyPSRHLaqI1rh55f8DvTpMEaxhEJ0s3vPqNQZ5hUTUYRSOV1B1yLeLgVZTSZURBADg6hScYmk/2/fbklntNcQFqmjXcqLQxIXIqDm/CSt+YwqU4cG9jeAxbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D+aNsUu9; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728661524; bh=Zl3/D+6y7HI3TEg3CIvo46/vvwEgBKmvavaGc3sU/r4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=D+aNsUu9+LdQcKiQUSa8x1gKTuzbYoTsV7xzwhK6uq4tYwO0CM38gN60CmUCmfAKWBRW785DP8BAOdKB3LCG7ixRKKZWjvct+obPKFS3aKJx5PmAZ0WrNYNkFXDPnjCLY01gRG5uYgxYyD0nY4POLx6LAwr+4lDcZtNtjX4NJPQHSMM6U2mfHcqiNH67LfaExIQ1gzEFu/r+cOtJ60ztSbX9diy/rkF4XJCNUQpExDJgqhKnb29PozhBD2NRw2gfeWTri0Hz8amHT0S3W/ElNA2z9EKCXRNjqJKc8DFa2z1MPPpGrNmzoHaVl0GDeAdYgiMcDXTMTPCSlItWOVJ8cA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728661524; bh=w9gCtYguL6n11vJQ4fVljGoD4rfigGM2plM52X///Q1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=g+0yjnZA4pJNN9GYrAvMNfVsxE65pWTkQjy3qlL5+8hGeScm1/Fe/XboCcqH8vvcm0nmBuI8bW5FmUrmqWYoNFeuWmVBySu1VYd3HoI+6ypOfyvoVWjgBMqNZqbf40F8DiZJepSw+bZmgTErdCHANAxDHPFH6UsFJLzCo3WRu+PA1PLVOb11vMullXXHL6UiS0SE4kAGUAhCqobCueHS72JQGon9htW5rJpcYI1u3FL+G+OaHc6H8Kfjszkj8m55Bv2Nx+tNemkGwFxqgNEynwxD3nk0Ifg0kCOuCLhWj20pg0tzJdR7LC8x5thS0NsGFfXKhZ0xpZUTeCkcFy8UUQ==
X-YMail-OSG: gU3cfakVM1mj7H_VcPpD_c8dGIS9CE5TsIQivt9C4nbWK7AXhTJg36J5FYn1Vdu
 P.hVVsOBkNc5_F7d8T_wGuaKECgbK33F0HBo7qWIyJ_vTGdBjGRlp02EGRQPyzYgfDRC0sKkTt4y
 xbKNngXtY5wXj4Xd9bZNHWXaJaMdoew206pAIbWKUAA0nm_.lAEFHMsz1RCPfMK4sCmk4NvX_gGJ
 zxgWoipxtYOPZse1be6omXXKMaSTUWxknPRhDg.yhpkU1iOgHcy3hHDofFodmSZNq9qYiUkIj7OM
 QIA1VdwnwpkWh8.j.GgBctj5bo8JZFDydm_P_W8A0Y.Hpf4llO8Zt4FGVa1_2QVnta0Ofidez.QF
 gn_9ZQZQxCr97WLo4xCLgd2Hg6NQaUX0WIzvpjGNq_9fpG8vuHEUd0X7Psxh0vdDa_xAWRLn4t75
 U9B.RyXfXUKwk03TLFsPAGhGKEqcqOB_IYE35mfSoNT6DYEazjVr_DNwJxnFWCDGNn8VeSroRQF0
 Gf0jAWrGRShuRvVGHWmoAK_z3tz8M.hsbz5soABnYV5wEwNcT0Y5LhDABg.cuq9hzgmEPHq6ClqW
 TDUp2cb63AkkyecIewznVtwSJ3t6gXzoB_gKsUX7n.rkQsCJZCLiHo.OV1wZ07ZFeEGrnuupWP1F
 QbGTnA58Z1e7nzXuE1dhKg25mnTJEys_MIk7e2lC3ttzShX2TyH8nQSKthVhUO8glfD.FCIoMMEL
 RxDW06HDYE4UVp3FSXSyrAZMnQdT8nNHNzWMYA_8zkDZg3ekhFLXpH1snvYyhdyk9prqK4xRNTUZ
 yX9T1B7MdNZPc3CTHnUI0U7KU6mox8CGN4.LPOrEoELtEmaqUcJTqqWRE4whNVeVn1b9LppOF7Xk
 giEJirxEbxfCi79ktYYYNViFdTkGR3at8yCEyY81b1owuse.rkAdL8D_Fz6VpN5V.j9vkaOVxrca
 XbVDqwlhXBmXz8_9uFyoENLVidoVHj8allgTkiTLDaaEuNbL2WlKoL8jSpscYVJjr.adV2qZAzsm
 3ED5LhDQciz8QsPo1Ek.60d3bmSXv6pwIVsDRXEcuyX2YbYM49zUqyipJK16ZH7B7ip_bTVmwIWI
 6Uoa_rwfuhIYC9AXCIdN_yupv9VGor3GnKSaFXzLaBEHgDw41flALqNDwhT8L5RgnttKmDxkjiYl
 Q1fYdkKJU2V4RVcjwVOkpDQsOjoMbUatFYxH4wdyBA_fDZSZVrUlxEPYZkMyXhY8JyxXyftpMXhM
 _MV_HLZoWIG9AQG33ZeB6qArjKSJeKBw6diOc2kmpChfyrQ2S7qaZRyCiziL2_dDeQulmzpFI0Sn
 smzaHjOoBr4hPXElr5bwvq6EC_IDg8uNmZb3P.y.sNmQ4Fxgrpd3Xhj3Qrxx5iQaoFn2SBrmi43P
 T8rLztBXJeYIoAXz.MsLYpbUp3sN0NxyC3FSqmMYsVY5Ct7d7vY9p4OiwO4idsZ9SEdF5LZF22Hu
 eLxRY6vu0qXsY.s1v_0Dj_q29CaD4SN2PUg2zwnVJHfMjgjX92Vi_TzcF.03_6LbiLPJernDKy.R
 dMafeJ9AX.QSf._ANjf93VGQTaGGZLRLqnsg.UpNlMC5HcQG3LhV15vDaOSJzU8CCbpoXT8iaV4V
 tGOMIoYPhLxP3EIX5tFYjAOiOyef_Z.FXZ4y1Eud6qhqyZBAcdQWJNc52bUfD6oL_9oargRVqzL4
 _OaW6It50BYG03ppxJ3T7uU4GWvqxAg3LYMYxebgKens88T.mS9k5j0M0krCmS1E0pBFMXS1.PUi
 iLGb.jmJ76DEwi87g1J6C1S1L.rWz2Fj.wSkQkOY60IenozZ8MgkYPBqXr2WBmVO3sgxQ1sVhHdO
 Gko6wAvMuly7FpErQqpN8KddZoPDvHBKFJrOXsE0v5lvUizA46B.vpQfdh7b3IY1MPkgJ7_iaxr.
 s0fMIxNnH5CL8AUR6mJm83DUB6qFkM6yyt61JPSfzBOndfkwYWzzyHWLp0G9eyfznUQHwraTjJX4
 fLBNfNXEXAyDBcdLoqZk.5EUEuf_n3LXahb.4AnUYKC73Er34se.sgvBQRCsj0FlWRjfQ03cWEZZ
 hKxsYOHPwifTLGacTRL7_lWKcncatdheN98TOzcoQCfYTRDn6gaRVpRxGaxG8GBFLvQaaqr.ANjp
 xtgTZRKx8nsfb8krZVKW0RuEBHMZe5f4DejrWehv1xusc4tFEtLNpNSkmGAGQ1GP94pOnsLcMFzA
 6zVTkBGtaxUliA_jo0fXPlscOHyh8xVuGjvBpZgA1IKOuFyVSJgOI9x99l.dgoNdM3EKUXcRHxUO
 UuvblGQ6vHp_4.dozVjKhGJ7oI2c0qBMFgI4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7ffac3f6-d9b3-4c13-aa62-50fffeef9c53
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Oct 2024 15:45:24 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8eeba5143bfa479ac5e23185bad5640a;
          Fri, 11 Oct 2024 15:45:18 +0000 (UTC)
Message-ID: <c346f1a8-8edb-4736-ba78-998316ef611d@schaufler-ca.com>
Date: Fri, 11 Oct 2024 08:45:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/13] LSM: Add the lsm_prop data structure.
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 selinux@vger.kernel.org, mic@digikod.net, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20241009173222.12219-2-casey@schaufler-ca.com>
 <1e6f94db91f0df07373ec1e0c8f3eced@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1e6f94db91f0df07373ec1e0c8f3eced@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/2024 8:08 PM, Paul Moore wrote:
> On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> When more than one security module is exporting data to audit and
>> networking sub-systems a single 32 bit integer is no longer
>> sufficient to represent the data. Add a structure to be used instead.
>>
>> The lsm_prop structure definition is intended to keep the LSM
>> specific information private to the individual security modules.
>> The module specific information is included in a new set of
>> header files under include/lsm. Each security module is allowed
>> to define the information included for its use in the lsm_prop.
>> SELinux includes a u32 secid. Smack includes a pointer into its
>> global label list. The conditional compilation based on feature
>> inclusion is contained in the include/lsm files.
>>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: apparmor@lists.ubuntu.com
>> Cc: bpf@vger.kernel.org
>> Cc: selinux@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> ---
>>  include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>>  include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>>  include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>>  include/linux/lsm/smack.h    | 17 +++++++++++++++++
>>  include/linux/security.h     | 20 ++++++++++++++++++++
>>  5 files changed, 86 insertions(+)
>>  create mode 100644 include/linux/lsm/apparmor.h
>>  create mode 100644 include/linux/lsm/bpf.h
>>  create mode 100644 include/linux/lsm/selinux.h
>>  create mode 100644 include/linux/lsm/smack.h
> Looks good to me, thanks for the lsm_prop rename.  As a FYI, I did add
> a line to the MAINTAINERS entry for include/linux/lsm/.

Thank you. 

>
> --
> paul-moore.com

