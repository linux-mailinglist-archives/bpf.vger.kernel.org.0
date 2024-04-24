Return-Path: <bpf+bounces-27685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8541F8B0D76
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 16:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D321C24D52
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E45915EFBE;
	Wed, 24 Apr 2024 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wdm8zxbF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HCI0zPS7"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D92158A3D
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970771; cv=fail; b=smYR3Om6xPRNs5nohLQ1vtOE8Fee8xXag7c9OorBq1sZzcXP6dfJR99I+vIqTNHqaQzNpV2OSdDfP8CTiPOgzdyA6P+MM1F6jGXOBIF6avCkMuED+ExI+l4SuNucBUfJKIMrN4McTR3Hj/v+DvbCnqRB6tcJiByeAXPGlXGl0NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970771; c=relaxed/simple;
	bh=DldO5XOGRtEQw0nnyZxObM80ltsw2RwxFBkhYDdX0jI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=My85WWSYzzZKl+LIhowcdVp5Tt3nThnwOkxo8m2FM5BrtCjqOKmvooSrNb/nq0PO9w7a5GA3sBMAvR1j/E4RErgqpMz0ethCs48JR3eSCElguFcJLhhSTBXYc/91+ZrrhbNCclvQ5mBuQuXf8e6o4npE8OJHlOuLwxWyFhQLE/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wdm8zxbF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HCI0zPS7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OAL9ue020635;
	Wed, 24 Apr 2024 14:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ZQSXekp4J1lbdEMhJNmmNQol87VUZdTZ+OwAXHsVDp0=;
 b=Wdm8zxbFdim9vldbiCq56iRH7cEIE/DErJjiFdPJxi2bV49c6oOmCXcIIpkfakkLr9/e
 /yReiZwFzf9oeYKTbxbAax3u+V2VMhIkcbeVvVG/NV8ORv1fO4CAksboXP2GCg/qGPaD
 dLRyp8EE174lcl50+d1c+8Od6cjzpH539gLv9nz1cYX8cp0JLMLsHKrki+oCkV6E0B+v
 G2wdQ43vx0vzROLxA7UsWi8+ff3Iw7QoTTeJN3HaeCKRKuRKuKbr2l1Ij2zXIkdD5/LM
 JhAECtwqjXRHveZAXbByngC9dVTekwT5lp8IjF0PA9aBEmcJ85b9LKJjg/8NaLsQrsBK 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2gxmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:59:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ODjQX5019661;
	Wed, 24 Apr 2024 14:59:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf4xkqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:59:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2CcerSDIfVQ7qxUWLNr+nm2CuEvbJJbpsrqCLF7U0sVlBqF+J53/ou6sdJCpLzyqNU4e0LUdE2gI67Vv9b1cLCVbBCTiuNmNC0U0lb9FdyZLpCGzxF3bM0mJq1rBWRGG+BGuojUKAPQ64RQwvNYLla7UC6pe2HD3bflc3UXO8jbPOAh7JTVhO9BqWWnbEXqel2HIgdye0n7s1tiB9y4KSdj5O+wD/5DblkwudwngJPV8Ploc5fdpVVrACk6WQmjfQQ8rIPOeoGS0tZzmGtUC5URpxKe58FW67r9Waf7+pfqMB4iybbk6lcZKtV8IKaeiim82YLGZvGBh4mUUA1zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQSXekp4J1lbdEMhJNmmNQol87VUZdTZ+OwAXHsVDp0=;
 b=Oth0oiRv91anF9RSfwm/NkMaznLIanL3JSJ+hIg2yKtCo7EpGphI5u9rX1CuVfu726YbHPgFMMbJ3XNjGNMCjsJCaObnas4TTzZ9R0Xz+V/HYpwWi2L8hv/q64eUpYIoTAcpTiOQih5pE+eqNbN2MNuA+sVKgkwyoIInoZgKh7JptfDB0vc+CqUJZsdObxBE5KBd5bYPaqw5XuISm6ZrpxvHK5xHch5ES5j+THWMpi1cnfmVROTzGFQssVBTHYPLvzekCatXt9q7h3G2NiHpVffSDwbJLRxP/0Bwbcn72KX0AeMRGvoiWPBr12zwfbVv63SWir3a9c20rd6K6zQUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQSXekp4J1lbdEMhJNmmNQol87VUZdTZ+OwAXHsVDp0=;
 b=HCI0zPS7K5V4Syznyk2JuCsFpCrkbgv+AbbsiW4I3IJ96XD2DViC5FQUTMZzXGlxnEMBoHuY9QKnsO+wGiTbPAVY1zElekDdr7sunwPTPc+FeQTlrSJLRunzUZB9Mak9rM17e5FFKvEAAJerXvSCwkVOg1rPWQlUcNEOqYOUMoI=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by BL3PR10MB6017.namprd10.prod.outlook.com (2603:10b6:208:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:59:06 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 14:59:06 +0000
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
 <20240417122341.331524-5-cupertino.miranda@oracle.com>
 <78488c062d4154f78706d371bf3ed600a0601ab6.camel@gmail.com>
 <8734rhk7jq.fsf@oracle.com>
 <2ec6f3bf-c811-416d-aa28-bc97a994f03e@linux.dev>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust
 <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf/verifier: relax MUL range
 computation check
In-reply-to: <2ec6f3bf-c811-416d-aa28-bc97a994f03e@linux.dev>
Date: Wed, 24 Apr 2024 15:59:01 +0100
Message-ID: <87ttjqzu16.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0555.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::8) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|BL3PR10MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: 03547f2f-5ce6-491f-c880-08dc646f1659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DlpQBz7IH0KlDZmi3kyOD8Z406VbAnvKusgjodOQqTs70SHWvKarjDtmf6s7?=
 =?us-ascii?Q?eOKTth4AKJU7boW6VbXjA612hLd3h8cX4SHR9idPxRceQholJX/DutYPwaYR?=
 =?us-ascii?Q?G7Z/eO2Ivt7tCaYdGIz+0U9ff8kjBpuSKskTt0B7BERVQWl1P3c89mMH2xZ8?=
 =?us-ascii?Q?79Ary7hu6/6sev3hQ2jTei9Ij03bQ+h1nJomVdgOF24RgbajDCl0FbNwY7zI?=
 =?us-ascii?Q?U9zhjNOpQioMNJv+8s1iS4zPvCNyHAOgbXWtdyG6KV/gGdqclIHYTNtoof8A?=
 =?us-ascii?Q?BtWsqNnvU1hIIPwsvH8oFTP03KsVZ2J0+N+0mnLAECDfu+YuFuZYBbWJFAwi?=
 =?us-ascii?Q?osVfR0M2uNiWQgl4kooEWva+dbUdVwm7OBYr18E3C3Y/vyX6zLFx3GuA0ezr?=
 =?us-ascii?Q?UO4RH15zl87LIIf+T7VMxXYWLuCDvr89dF8Jl1Hq6pSGAJP6yErXGyw6mz4o?=
 =?us-ascii?Q?1GefqC6SmXOtjBgL5ze7OO8UwZMmlLzSemU2jXW+CSd5fY3XeYOYdUn5RCWT?=
 =?us-ascii?Q?5EGlZ/VOgNKcRPTStewe0L1rzSx1SPOjd+a7xfSnCkKZNaA7BXOTxyzhHtXh?=
 =?us-ascii?Q?IfK3sbsSnZ0vTIr1kyq3p97lw4ITazDg3OUJrfu2CwLsOR61s1Hxv9i3coTl?=
 =?us-ascii?Q?ccin6H0q4Rw/IcormacMPqKDd+knI0Fec+ZTUG7KYqfyTXaYJWnA4YbJ6UZa?=
 =?us-ascii?Q?4/gB3/CBvOhUoZJ3DyyeBw/fBg0BcGQ0h0OOBHIPGK/Zq6lUJoOFpgaIkIYX?=
 =?us-ascii?Q?lYdMVSx97sy3zkfXY3cV1EWagplZ5D2M6qop8mtEz6PR+yvSDguR5pa8lKzY?=
 =?us-ascii?Q?82JB2FlXzA8qA7vuq4Z6seET73KyNAFAjKDIJqpN3SnljvSAnNEDkzAMbF+l?=
 =?us-ascii?Q?lp62qx1gStrYNIVGJS1focGwpJy3SjKTnDEmFYrnHD+8fSZIXvqnmmA33+Rk?=
 =?us-ascii?Q?mfu5ZU2e630naXSiS82bdODsmrBmxlD7n6BGMx4K7L5BknE7MsLii+8eV13T?=
 =?us-ascii?Q?1F4xFLzhgFtVJebKdyaltjVIHw/boRhs3HHRUvrfBCcxqbvcx/5K22pEaAgQ?=
 =?us-ascii?Q?MjN+3kF4Dm+nMQ4F7zKE178JKUw662xnBEouD7TXpPX1QnlLhj3OudEu/LWM?=
 =?us-ascii?Q?3/szEmguu5oLNTFuJXlnfaFbrKRnxrlVxhGkT2eUdvRcedkKT285ioscGLNB?=
 =?us-ascii?Q?yEAcP2g7oJkd0YG6zQOmYdfbf6ZD9utYEuW9g100YeiwSqSE/Vkw1EfyYRQC?=
 =?us-ascii?Q?m2kCrc/cbpmmxz/tZd3s9W2nMYvGUxDQ3+muu4xUFw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nNkotHWFrGXDZvajdT26KzcNinxw+w3OGyaqGSPBZlLahWOt4rfUs3LB68iz?=
 =?us-ascii?Q?hLGs7hGk8rEEf40/tqngr2mrtB/+UIRixO2nySU46nWi5aDA5u/gP8or/xk3?=
 =?us-ascii?Q?oRJke96oNko3oWy2F1c2DzKB1T0aX4mKuncTiEkryVMFnlQiZB3svDLTmhLI?=
 =?us-ascii?Q?L2MlyW6q8GfmqMFeztyOx/g3L1dnOzvnMQrl4MGnApF2IlWiCzMpDP8vs6hr?=
 =?us-ascii?Q?xLVayVTUxgo2+9fJt1300DMnLYi+q5Gr5hHVTGT45k+8uhm9T05wIh2SB7TE?=
 =?us-ascii?Q?YnHm10kM3RCyMVuHcRPVPdd4oVmHl5TeYl+mXVn8vKrJ7tO39b45SG64XbO4?=
 =?us-ascii?Q?t4W93vJYAvQayH5yvAPeiv/KZql2uI/+G5nzft9uXlILJ0flC5doLm5cjRjL?=
 =?us-ascii?Q?wgM4leC+7oTkwtoB7Tk+JImf1MA5s/k+BWCQdHGZOk3wYZpmuDe1Ro4NX+/Y?=
 =?us-ascii?Q?5xCPSzupF1l6ov90SzKgEBWH+J9YT1xtyEhmGnTGgvBc6YLRJd6fdXrtBlyH?=
 =?us-ascii?Q?e5GbizFkx1c4fjBb8VfJfsyvBzDUPwNfFbP6+2L0GHyaoYc9lnrvogIB1N2P?=
 =?us-ascii?Q?dT9Lo53WScTDPNXZ8ysEHqJYuQkR5WCNzEkib0CurfuQC4XaYpLkU3noa7gp?=
 =?us-ascii?Q?axVMjq7nOEoH2WfnbIZv4tmn5pEfI2wy6AdgiGKm9dSPvPw36TCblLrJlf6q?=
 =?us-ascii?Q?QeeWaTSbSK2tTBTedglMFpmTyl13jmr5oi9J4qET0PntaA5i0T+v8f4wkLD3?=
 =?us-ascii?Q?wmKDGiD6iaiy3xidJnn7uv2knYbA7q+uY8wnX6ilhyOYQjvwaxL1Xxxrt4vg?=
 =?us-ascii?Q?NKhMHyd7o4O51qTsqeLJfVnv9iVe/i/f2Un0nJBv0zY8VDeQbJBXESpJqn2a?=
 =?us-ascii?Q?WZ9f7N7EmeHEThPzrAw6KqdJBxRmoJmVrC8KvRO08NBB4zjI6O8MiiSLK05q?=
 =?us-ascii?Q?7LrEN8EDGnLYDXg6xwTHFrEOE8C8b1+CFx8+mw43pBmIyEwGJ3zrDc43Pwuz?=
 =?us-ascii?Q?i3NcFeu+dlajVLj2jMTKocKRVKJOV3z/dOKIT15Mw38VyGTU2We9LyoeDvAG?=
 =?us-ascii?Q?bgB5yJ7Ce4qG50OUlugEQeT1CxcN3V/44A0kiUzhuvLUYHlb5mFCGjqfG5UJ?=
 =?us-ascii?Q?YQ3+kFL9hgmUWEXtp5pvqABCHQ1PykQf/I2cVYj9OghI+3jP7X4pGi6LQwcn?=
 =?us-ascii?Q?yxc6ZilRpKbcDlcP1XRYfPvcPufl2paO/rboTLguaqlaAqRc/abo+LuH2MgN?=
 =?us-ascii?Q?KPctDdiHqSsvvSkMs1OMpbFfbFWCbnNK4BMid09PODHsu7NkWh5u0ZjIPX05?=
 =?us-ascii?Q?rFboK89UC7gwFz0zT5jdNrxLO7KpexdpchE5FCs0a//4RGI6fj+qERX+Mi6U?=
 =?us-ascii?Q?2hsTMjDizZxpX7KRhiAeyQ/pWQ5V1KoR7PNWi/zT0XZiVT2PZ6Jw3zSakfUy?=
 =?us-ascii?Q?eLNO13y+TmlzqIFPY5YJBgsIDjXTu2qJtogZbJ0XJMjcQ+E5g8JYREMyZaD+?=
 =?us-ascii?Q?BWBeKe/V5yqp/w80JLZ2xyDFr8IC0E3tDGj1Ts89kF99Qc/oR3/cmSkbETas?=
 =?us-ascii?Q?mtOse2BIJEG0SkIo2QrbdAb4wFUyAQtvwZSGxxz74e3LWAwzYqQYTOOc7OiG?=
 =?us-ascii?Q?p5/8QCwrBBHotBWR4kjsgdw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q9Wn4z9BZl3nRlkp/ygtUdfOJs19odqM5dT/hTdJhEadnSZTlbm6fkfQZYo+kCB3NR8g6NKV3gxeILU72b4ehtQE+QZZ1qSIsc4YkzgecE9f6VgzT8ukbOZu6rQdoJYGrjaoTXiNp+B8YBROaphMhIiPMaCf8M0pfFOHcjAqyNE6zPtFiXC0uCWcMyKrkuVDEwrL1fDpy2IzTOWPSGTnfN4ns/Spb9gBjokIVec0RFHuiLkk/jagZO7oYDrtA6NEK0wRhGaE7Q3hRUBnvLwwbj3Z867vaoJyuqR4NCej9topXftLk/JyV6Y73g5WWhDkWHZT77a8TtYM/qJqnvKDh72SgzI0/eaSWTphMuhvDuPuRFMEZpqrm7fvyKItFLaEQZhl5S3H0C9KCm/OPc7cg8WLtRXlgIQLtqYvl230Xn6CDLlyU+Mw9nLy16P/kZPCKMCgnvsWDZwFMsgpZhBg0rzfLY/MDUbDs/13wP/OgjfGGSbHbIjwXBM1OeMXt0V1gwB+62UNBhI9eQDWDXhvM4lLBdDX2BXx/tJlP//7jPB59ROU6l1sNt0n5JQ8Yp10nkSp5qcUrM6wFTEk8f74GXefCd1l41M2+4N1JzDj3kI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03547f2f-5ce6-491f-c880-08dc646f1659
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:59:06.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/pGuQ+Hp7RaQ/lvjQicfjIf1WXGesXVkjbsB2U2tPgcv/8ocWfusDlkzHGIHeAMcdxahl1TT2JOgSxJLnMCM338B1JLS3ot5iF9wydL6qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6017
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240057
X-Proofpoint-GUID: eNtv69onLD7bJXamXH2xgYyJvO8rQ5nM
X-Proofpoint-ORIG-GUID: eNtv69onLD7bJXamXH2xgYyJvO8rQ5nM


Yonghong Song writes:

> On 4/19/24 2:47 AM, Cupertino Miranda wrote:
>> Eduard Zingerman writes:
>>
>>> On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
>>>
>>> [...]
>>>
>>>>   static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>>>> +					    struct bpf_reg_state dst_reg,
>>>>   					    struct bpf_reg_state src_reg)
>>> Nit: there is no need to pass {dst,src}_reg by value,
>>>       struct bpf_reg_state is 120 bytes in size
>>>      (but maybe compiler handles this).
>>>
>>>>   {
>>>> -	bool src_known;
>>>> +	bool src_known, dst_known;
>>>>   	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
>>>>   	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
>>>>   	u8 opcode = BPF_OP(insn->code);
>>>>
>>>> -	bool valid_known = true;
>>>> -	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
>>>> +	bool valid_known_src = true;
>>>> +	bool valid_known_dst = true;
>>>> +	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known_src);
>>>> +	dst_known = is_const_reg_and_valid(dst_reg, alu32, &valid_known_dst);
>>>>
>>>>   	/* Taint dst register if offset had invalid bounds
>>>>   	 * derived from e.g. dead branches.
>>>>   	 */
>>>> -	if (valid_known == false)
>>>> +	if (valid_known_src == false)
>>>>   		return UNCOMPUTABLE_RANGE;
>>>>
>>>>   	switch (opcode) {
>>>> @@ -13457,10 +13460,12 @@ static int is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
>>>>   	case BPF_OR:
>>>>   		return COMPUTABLE_RANGE;
>>>>
>>>> -	/* Compute range for the following only if the src_reg is known.
>>>> +	/* Compute range for MUL if at least one of its registers is known.
>>>>   	 */
>>>>   	case BPF_MUL:
>>>> -		return src_known ? COMPUTABLE_RANGE : UNCOMPUTABLE_RANGE;
>>>> +		if (src_known || (dst_known && valid_known_dst))
>>>> +			return COMPUTABLE_RANGE;
>>>> +		break;
>>> Is it even necessary to restrict src or dst to be known?
>>> adjust_scalar_min_max_vals() logic for multiplication looks as follows:
>>>
>>> 	case BPF_MUL:
>>> 		dst_reg->var_off = tnum_mul(dst_reg->var_off, src_reg.var_off);
>>> 		scalar32_min_max_mul(dst_reg, &src_reg);
>>> 		scalar_min_max_mul(dst_reg, &src_reg);
>>> 		break;
>>>
>>> Where tnum_mul() refers to a paper, and that paper does not restrict
>>> abstract multiplication algorithm to constant values on either side.
>>> The scalar_min_max_mul() and scalar32_min_max_mul() are similar:
>>> - if both src and dst are positive
>>> - if overflow is not possible
>>> - adjust dst->min *= src->min
>>> - adjust dst->max *= src->max
>>>
>>> I think this should work just fine if neither of src or dst is a known constant.
>>> What do you think?
>>>
>> With the refactor this looked like an armless change. Indeed if we agree
>> that the algorithm covers all scenarios, then why not.
>> I did not study the paper or the scalar_min_max_mul function nearly
>> enough to know for sure.
>
> I double checked and I think Eduard is correct. src_known checking
> is not necessary for multiplication. It would be great if you can
> add this change as well in the patch set.
Sure! Thanks for confirming this.
>
>>> [...]

