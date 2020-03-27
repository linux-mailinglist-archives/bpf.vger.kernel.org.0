Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807DB195722
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgC0MdZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 08:33:25 -0400
Received: from USAT19PA24.eemsg.mail.mil ([214.24.22.198]:30101 "EHLO
        USAT19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0MdY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Mar 2020 08:33:24 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 08:33:24 EDT
X-EEMSG-check-017: 94443209|USAT19PA24_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="94443209"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2020 12:26:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1585311978; x=1616847978;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nJOJTLtz/k3jyAYnPH9n4459RFem8w2ja71CkwOey+8=;
  b=PBNGDnjDLN3tetVOkog3GlcRj+CQgUpU0HONlNnJvSbQFgGvcb8njHdK
   iLeUkYiBI9LuStlcLZB0b2WhOb+zhZ0uvkktnbe3ZuRn/iXavtAjXnVvh
   nsrTI1t9Qr9qEt2G25iu2O1gRDaFPEa7iRYIbN3WNvdIiiXSB8Hjlc6iL
   h5JMVIk/hl8HpI2bozCWN27mDdfbVenk4f9HktCyIu20Fx6A198dJJ/yD
   xSo1PpPPdRFOCfFXQc9aQ4FF+VzgGuwygnLTnxHqMRXGRSL8pQAPngCUl
   Hz4VufgLtZJq90QKAGV+NmJa5ie5iz1AOgkOJLKS368w68quUrDun63VG
   g==;
X-IronPort-AV: E=Sophos;i="5.72,312,1580774400"; 
   d="scan'208";a="41128694"
IronPort-PHdr: =?us-ascii?q?9a23=3AIcnUnBzoD93mQtHXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd0uwfL/ad9pjvdHbS+e9qxAeQG9mCt7Qd1rud6P+ocFdDyKjCmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfLx/IA+roQjRssQajoVvJ6QswR?=
 =?us-ascii?q?bVv3VEfPhbymxvKV+PhRj3+92+/IRk8yReuvIh89BPXKDndKkmTrJWESorPX?=
 =?us-ascii?q?kt6MLkqRfMQw2P5mABUmoNiRpHHxLF7BDhUZjvtCbxq/dw1zObPc3ySrA0RC?=
 =?us-ascii?q?ii4qJ2QxLmlCsLKzg0+3zMh8dukKxUvg6upx1nw47Vfo6VMuZ+frjAdt8eXG?=
 =?us-ascii?q?ZNQ9pdWzBEDo66YYQPFe4BNvtGoYf7qVUFsB+yCRCsCe7rzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzIwRIuH9wOvnrXotv6OqgdXuKpw6fH1jjDc/Fb1C3h5ITUfB0so/eBVq?=
 =?us-ascii?q?9wf8rLzkkvEhvIgEiMqYP7JzOV1voCs26G5OR9UOKgkWonqwVvrTmv28whjZ?=
 =?us-ascii?q?LJiZ8Oyl3f6SV4wJo6Jd2/SEJhZ96kC4FfuzuVN4txXMMvWmdlszs5xL0eoZ?=
 =?us-ascii?q?O3YScHxZs9yxPfdvCLaZaE7x39WOqLPDt1gm9udqiliBao60egz/XxVsyz0F?=
 =?us-ascii?q?lXsCVIisLMtnUR1xzL7ciHV+d98l+h2TmR0wDT7flJIVwumqrBKp4h36Uwmo?=
 =?us-ascii?q?APsUXDAiD2mEL2gLWQdko44ein9/7rYrDnpp+YL4N0iwf+PboymsGnHOg1PQ?=
 =?us-ascii?q?cDU3Kb9OihzrHv40L0TKtQgvEriqXZtYrVJcUfpq63GQ9V1YMj5g6kDzi7y9?=
 =?us-ascii?q?QVhmUHLVJZdxKHiIjlIVfOIOviAvuljFSslylry+jcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?Z/7k5czxAzzcpe55JPEbwBJuj8Wkrvu9zZFBM5NBa0w+n/AtVnyoweQX6PAr?=
 =?us-ascii?q?OeMK7Ksl+I/vkvI+iKZI8auDbwMOQq5/70jX8+nF8dfLSp3Z4NZHC/BPRmLF?=
 =?us-ascii?q?2TYWDwjdcZDWcKog0+QfTuiF2DVz5TenmzU7s/5j4lEoKmC5nMRoS2jbyf0y?=
 =?us-ascii?q?e0AIdWanpFCl+SC3focZuLW/MWZCKVOM9hnSQOVaK9RI85yRGuqAj6xqJ8Ie?=
 =?us-ascii?q?rM9C0Vrozj1Ndr6O3Jjx0y9iJ7D96b026TS2F4hGQIRyU53Kpnu0xy1k+D0b?=
 =?us-ascii?q?Rkg/xfDdFT4/JJUgEnNZ/T1uB6EM79VR7cfteTSVamXtWnDSg0TtI23tAOfk?=
 =?us-ascii?q?J9FMu5gxDd0CqlHaUVm6aIBJMq6KLc2Wb+J8Jnx3bBzqkhgEEsQtFTOm2+mq?=
 =?us-ascii?q?5/6w/TCpbLk0qDi6mqdqEc0zTL9GiY1meOs0ZYUAl/UaXBQ38TfFfZrdP85k?=
 =?us-ascii?q?naVb+hFawnMhddyc6FMqZKcMPmjUtYS/f4JNTTeG2xm2C3BRaHwrODcpDmdH?=
 =?us-ascii?q?ka3CXYEEIEiRwc/W6aNQgiASesu3jRDCdyFV/0YEPj7/N+qHWlQU8w1Q2KaF?=
 =?us-ascii?q?dh17Wt8B4PmfOcU+8T3q4DuCo5tjp7BlC939PIBNqEvAdhfaJcYdwj71hdz2?=
 =?us-ascii?q?LWrAt9P5O6I6BkmFEebxx9v1ny2BVvFoVAjc8qoWspzAVsN62Yy09OdzSf3Z?=
 =?us-ascii?q?DzIbDYNmny/Aqoa67T21HezdOW9r0I6PQipFXppBupGVY683V7z9lV1GOR5o?=
 =?us-ascii?q?3IDAoOSp/xXUE39x91p7HefCYx/Z/b1XppMaOsqD/Nx8opBPc5yhanZ9pfMr?=
 =?us-ascii?q?mLFAn0E80aHMWuJ+sqm1+mbhIAIu9e7rI7P8Sjd/Gewq6kIP5gnC66jWRA+I?=
 =?us-ascii?q?19yFyD9zRiRe7Tw5YI2O2X3gudVzf7iVehs933mYVeaTEVBGq/xjDuBJRNaa?=
 =?us-ascii?q?1qYYYLFWCuLtW1xtpkm5HtWHtY+0SlB1wdw8KmZRqSb0b63Q1V1EQXvHmnlT?=
 =?us-ascii?q?G/zzxunDEjtrCf0zDWw+T+aBoHPXZGRGZ4jVjyLoi0jNAaUVOsbwgokhul+E?=
 =?us-ascii?q?n7x6ZcpKRiKWncXF1HfzT3L2FlVKu8rL2CY9RA6JkwqyVYTPy8YUyGSr76ux?=
 =?us-ascii?q?YayznsH3ZaxD0gbzGloIj5nxhjhGKYK3Zzq2DZdt9qyRjD49zcQK0Z4j1TZi?=
 =?us-ascii?q?B9hCKfI1+mJdiytYGWkpDZqOGlf2SoU5BSNy7xwtXE/AiDrVZrBxK/16Swgs?=
 =?us-ascii?q?bmFwc6+ST7zd5vVDjN6hHmbd+4+b69NLdcYkRwBFL6o/F/E4V6n5p40Iocwl?=
 =?us-ascii?q?AGl56V+jwBim61PtJFj/GtJEERTCIGloaGqDPu31duezfQmtP0?=
X-IPAS-Result: =?us-ascii?q?A2ApAACd8H1e/wHyM5BmGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBaQQBAQELAYF8LIFAATKERI58UgEBBoEKLYl7j1KBewoBAQEBAQEBAQE0A?=
 =?us-ascii?q?QIEAQGERAKCMSQ2Bw4CEAEBAQUBAQEBAQUDAQFshWKCOykBgwwBBSMVQRALD?=
 =?us-ascii?q?goCAiYCAlcGAQwIAQGCYz+CWCWsMIEyhUuDUoE+gQ4qAYwuGnmBB4ERJw+CX?=
 =?us-ascii?q?j6HYIJeBJA5XYZsmFuCRoJWlDAGHZtpjxSdewkpgVgrCAIYCCEPgyhPGA2dA?=
 =?us-ascii?q?SUDgTYBAY1+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Mar 2020 12:26:16 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 02RCQPup174506;
        Fri, 27 Mar 2020 08:26:31 -0400
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
To:     James Morris <jmorris@namei.org>, KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
Date:   Fri, 27 Mar 2020 08:27:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2003271119420.17089@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/26/20 8:24 PM, James Morris wrote:
> On Thu, 26 Mar 2020, KP Singh wrote:
> 
>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>> +			const struct bpf_prog *prog)
>> +{
>> +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
>> +	 */
>> +	if (!capable(CAP_MAC_ADMIN))
>> +		return -EPERM;
>> +
> 
> Stephen, can you confirm that your concerns around this are resolved
> (IIRC, by SELinux implementing a bpf_prog callback) ?

I guess the only residual concern I have is that CAP_MAC_ADMIN means 
something different to SELinux (ability to get/set file security 
contexts unknown to the currently loaded policy), so leaving the 
CAP_MAC_ADMIN check here (versus calling a new security hook here and 
checking CAP_MAC_ADMIN in the implementation of that hook for the 
modules that want that) conflates two very different things.  Prior to 
this patch, there are no users of CAP_MAC_ADMIN outside of individual 
security modules; it is only checked in module-specific logic within 
apparmor, safesetid, selinux, and smack, so the meaning was module-specific.




