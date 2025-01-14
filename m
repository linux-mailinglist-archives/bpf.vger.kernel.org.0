Return-Path: <bpf+bounces-48754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C65FA10479
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E1F1884766
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 10:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB51C4617;
	Tue, 14 Jan 2025 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tZ1HP7V2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E027229602;
	Tue, 14 Jan 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851250; cv=none; b=Dko9RFQadX4G47W4lPlWwLZ5lvOaCcy0DrleqB9HswQWIY7vfKP22zPwy4CsjZHA7PHZVfYou4/tiQ+gv59ARsM4mjQmkycJF/bvEJS5dCcXb0/i2X1RlTRTY0HfTfZOdW6ScTw8OIRXaLSSeby4vNDZ4XY0tm6UQvMS1bB+12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851250; c=relaxed/simple;
	bh=1Y+chE6Ha5kXxf9H5fIMPndawM3gx2ijZbQyfyJZrmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP8pHBB6o85SbOGdo1+saxO5IPhC0mAC16c2ejbQWpr5uXoSGUwjUC3UGzyiInd5ifsSSXAD8FK2PeQp+vQp6/C68K9VOlnv43oh1fvf5GMTNxXnIT17Vi6RbAoPAi2SMA2JF4TxKsKQ7ip/EL9Df/1Nx+SLEivdLpym+tFVCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tZ1HP7V2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E3qKUj019757;
	Tue, 14 Jan 2025 10:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yhCtdbFeE0NYehevHQ+x9yHLWQYFhH
	TgS6uxD6xzEFg=; b=tZ1HP7V2gPdyVdUjKRkVDzZzeIfuZTYV3DPe1KTcNr1AQ+
	d4m5oLGxU5SuPWMePnZY6jUiau4k1Zi9veQ1/JuCYZuCWcEnqBMOyEYm4RLWMnlB
	OzFtfd5KDEMxinc4hZkrsgIhj7MWz5+frl7wPyLnoTLsB8x0j/SSufTXNHToJN1v
	kjUKxKTt8nurMI9Y4NP1CLqLuIMP/csxRyw//3NzZL0ZiNhGr9V3EnFhkR8Kn9v5
	/3ZVB3cHpt2ep092ldZZ7TMwtQUtFuJc+Y7z2Sp0MZH4aDYjKWQiHqQeAMXqPrBE
	854C6iV3ueohqAIDnZnRbXC248bW65uePRw+cnMg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445gdc9eyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 10:40:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50E8ePHe004540;
	Tue, 14 Jan 2025 10:40:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4442ysjypp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 10:40:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EAeUmB35520936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 10:40:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE6AB20043;
	Tue, 14 Jan 2025 10:40:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98AA320040;
	Tue, 14 Jan 2025 10:40:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.208.233])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 14 Jan 2025 10:40:28 +0000 (GMT)
Date: Tue, 14 Jan 2025 16:10:23 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
        "sdf@fomichev.me" <sdf@fomichev.me>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>, "ast@kernel.org" <ast@kernel.org>
Subject: Re: [RFC] Fix mismatch in if_xdp.h between tools and kernel UAPI
Message-ID: <Z4Y_F_OeqBnizGss@linux.ibm.com>
References: <Z4TjzzB8NSnTy_Wa@linux.ibm.com>
 <PH0PR11MB5830E291DCB6B52EA651B076D8182@PH0PR11MB5830.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5830E291DCB6B52EA651B076D8182@PH0PR11MB5830.namprd11.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: htObJame9js9ilPK1KJbXVKV9qqk74IM
X-Proofpoint-GUID: htObJame9js9ilPK1KJbXVKV9qqk74IM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=908 spamscore=0
 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140087

On Tue, Jan 14, 2025 at 01:05:06AM +0000, Song, Yoong Siang wrote:
> On Monday, January 13, 2025 5:59 PM, Vishal Chourasia <vishalc@linux.ibm.com> wrote:
> >Hello all,
> >
> >While building libbpf, I encountered the following warning:
> >
> >Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from
> >latest version at 'include/uapi/linux/if_xdp.h'
> >
> >A brief diff shows discrepancies in the doc comments regarding `union
> >xsk_tx_metadata` vs. `struct xsk_tx_metadata` references. Below is the
> >relevant snippet:
> >$ diff tools/include/uapi/linux/if_xdp.h include/uapi/linux/if_xdp.h
> >120c120
> ><  * field of union xsk_tx_metadata.
> >---
> >>  * field of struct xsk_tx_metadata.
> >125c125
> ><  * are communicated via csum_start and csum_offset fields of union
> >---
> >>  * are communicated via csum_start and csum_offset fields of struct
> >
> >This patch aligns the documentation in
> >`tools/include/uapi/linux/if_xdp.h` with the kernel UAPI header in
> >`include/uapi/linux/if_xdp.h` to remove the mismatch and associated
> >warning.
> >
> >Please consider applying this fix. Let me know if there are any
> >questions or if additional changes are needed.
> >
> >vishal.c
> 
> Hi Vishal. C,
> 
> Thank you for bringing this to our attention. The changes look good to me.
> Could you please confirm if you will be submitting this patch formally,
> or do you need assistance to submit it?
> 
> Thanks & Regards,
> Siang

Hi Siang,

I need assistance as I am not well-versed in the code or the structures
involved here. I was unsure about the appropriate commit message,
so I submitted it as an RFC patch.

vishal.c 
> 
> >
> >diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
> >index 2f082b01ff228..42ec5ddaab8dc 100644
> >--- a/tools/include/uapi/linux/if_xdp.h
> >+++ b/tools/include/uapi/linux/if_xdp.h
> >@@ -117,12 +117,12 @@ struct xdp_options {
> >        ((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
> >
> > /* Request transmit timestamp. Upon completion, put it into tx_timestamp
> >- * field of union xsk_tx_metadata.
> >+ * field of struct xsk_tx_metadata.
> >  */
> > #define XDP_TXMD_FLAGS_TIMESTAMP               (1 << 0)
> >
> > /* Request transmit checksum offload. Checksum start position and offset
> >- * are communicated via csum_start and csum_offset fields of union
> >+ * are communicated via csum_start and csum_offset fields of struct
> >  * xsk_tx_metadata.
> >  */
> > #define XDP_TXMD_FLAGS_CHECKSUM                        (1 << 1)
> 

