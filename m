Return-Path: <bpf+bounces-40121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FBC97D26B
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 10:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9904B23FC9
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0505762EB;
	Fri, 20 Sep 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HFscIqC1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zNJAtQ61"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CD4487BF;
	Fri, 20 Sep 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820357; cv=fail; b=dR3e/tfxZV/1FcVZ1aTtjTrm+uBqT+FWirrpu1/Uv1kvXUB8xdNyKbgLCzyIAVKCSyynPhRAmmxN15y4ChPu6PljpSIeVk+WiTIRvb76EKhtMKK8libUBV6wZ8NqTByUnHzy8RT1fCxXKBT+OAZD75e4tJJjUkaMrWyqDB9lWEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820357; c=relaxed/simple;
	bh=avs3G9Dv2J5iF5l1n9x21JdKk74/bGSyOSsm9F8DxyA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fzLpSp5iQn9NaGnC9ma9GAa079iiChX3bt9amadNLSiLd+0WKP6KEv29yrTiGCNkrYL4jyvIEbepuhL/IK0XJ85betnAsB53mfFICt+9hBxC3URNK/SNBoaOuJ3H+nSXlGhhCDf0qXo2BlT8oI+6qEIwLFg6J1ltftcKyjG+6LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HFscIqC1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zNJAtQ61; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tXEs027904;
	Fri, 20 Sep 2024 08:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=wqk7SAbKnY/inv
	SffrLGsMdOcexyjVbqJCASDXZrx78=; b=HFscIqC1pGaIHl3NTrSlHbSJeC0vV7
	Tcq+n+h16+j+xRdPWGzzfU8lo7qxnBnepay0fAQgAJjbv15qAHw4MoNQMZ2Ga8fe
	vlEvNCrgWBzLHrwxsHRrBIUoFzqk+RBraR8bTCpxu4tZ00naW/00wGEvYABl8BkN
	LppO0GpREuXHnoK73813bOXJBFGYTQkjKVJV+uuRZRTen8Mdw88e0816bsuYrxYi
	v9XRYGzl1NNOFkSFLD1et8NVI0PCsYecKlfdkVS7DSfAx3QVyiizbxzZAMayJGV5
	aOxINaFIDmQQKOjyiuLepup42M2P5tyc3LZy6YreBng3nAFF4LUDTIqg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rx62j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K5mrbM018222;
	Fri, 20 Sep 2024 08:19:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd1jmya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFwbtVo4xp8e/LWsCFIVf9BIw2Eh+86Ncd2nyyQLSAZ0RFKrJYeg7BImwI1B6r9oI+WMDYLNkVbk7wCQApzAHZUNPUplwSaYJWeRkAXh7QursAMn7YrnbPh66xaCJc+LFNktjk/kJOk5ZsCDt/Gu3w5SodqOba0Se3+zLgLA/sVve/TdZXJgTXe3ObsFFsBYkeG63b0PFN/DaiA2XWUEPOzdHTnhBdWSLx78aRKCHrMyCbul3oRnGBHvzjZf4oGxWT7HyaF09tTPkJG/C+zerUqczuWh2C6lACYHrzp9+7QzUJY9L1ewO3vcmxW+JCGZpD/uGk2ID6h4Zorn/7JPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqk7SAbKnY/invSffrLGsMdOcexyjVbqJCASDXZrx78=;
 b=WFgYNfnEAEu2MHFMi4/xkthfUonwrAP/yhMtYfK6tyKGoLLLiUXGkSKhX6HmgrEy1olQ+CeRkwMcBETxHwMc2TV7yI+DHMk7oXkLdkn/6sQDqFAyGBZjJP8PS2oCbSUNxEU68/xBbJhVOS+lUnEtRU+pHsH4dWN8WfByqDgqi3H2aXfY2T97hwJJt4agSvI5eTe5EHfPLnEkDBn98bUgOJn4sXMcC1G+DN2goBpstuD5gcjV/CNJH00vnjWXEzyK9gmr5GeZqG6FIxWAS8dZt23E1fkBnHf+xAnRZk9VBq/+M4L8upI/fu0oOCRCmR5EPCzx9A0Kb6FG0iuNWxK/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqk7SAbKnY/invSffrLGsMdOcexyjVbqJCASDXZrx78=;
 b=zNJAtQ61kl04SOZaQZtetDCeHM1xY+Hb2IuAYC4poL5m/ddjrEDUHomVJG3Znx+mLyH1GlGieQZbOOFgpMnZkQUMIy4/VmTVDb/Wb6etX5rsuhrUMX7f8OXkenGYFi3XXIl9+xi5QrQjmu8UJtEJ/n/DO/xdeppiEzlMa0JYvf4=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.9; Fri, 20 Sep 2024 08:19:07 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 08:19:07 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 0/4] Emit global variables in BTF
Date: Fri, 20 Sep 2024 01:18:57 -0700
Message-ID: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0160.eurprd07.prod.outlook.com
 (2603:10a6:802:16::47) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: f787c6f2-28a6-4670-6f4a-08dcd94ce55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wnmen940nw2RCFtbwcqnoYz7g6l1yJCzVuRjHt17PPrKVlLLH1RU/YcycWRn?=
 =?us-ascii?Q?+/eWr7UCcpZ8aBz6FPo8k+lYaHpKEtZNwupubsOlx0EddEzk0Q3AsGAxRCvw?=
 =?us-ascii?Q?CfZVFNT3RDq8HmVOE4QFQef6a7oy5oML2+m1a37zaxMkTpISudlCYZ9TOzjG?=
 =?us-ascii?Q?DMZvkVuYrG08RvKgjLo97eOEs3gZWfgfokNebZruP7Bi4tJJLhxd9q/eziSG?=
 =?us-ascii?Q?snlT30ALLCPEVkrQFJtz/2lsoEOtSGTj6XNt081VVC6DHHo1XXIbdZ3F3Pu2?=
 =?us-ascii?Q?Yu3rHkLUGHoaHkFaLDjXoR3W+uzLaSbaCXjkeqrQ2ivzhnBJ311FHKyX3lx2?=
 =?us-ascii?Q?jOoOfzxkVGnQLfRiqzkd3jC5HMvdq0BhmfQwYcfyWBXTwpVNGqx9PEj63yxq?=
 =?us-ascii?Q?+tT3ZYnvnO6t4raYlZItw6MXTpE8vmYanZjKdUoMgs/wNs5kQjrqBNB9++cB?=
 =?us-ascii?Q?QZUFko4g6wrx2A1pHWmDCWndCAMO01V04dfwbOa1633PtoFOeI7I6FVtlCtU?=
 =?us-ascii?Q?W7UxAzA4rQfw6A5bunFSNSpojWM9h8a9d9BAnLOULjpl2Fp0Jf3y4oFlUGnn?=
 =?us-ascii?Q?IYQnWG4sO+83p5aycXsBlOa+o5TtDwDJ+j8d+TPQV4HUSCrvK3U88HZ1eEJg?=
 =?us-ascii?Q?m7d6oNz2bCrTpM2D1uoO3lCOYjCN2eaXtjZ5MHS2wJWKWNpcJ2PUewxVCAvA?=
 =?us-ascii?Q?buIeXTHnhMLW4R4qAXzrtX6GVFS3OzldjlaLpU0UHQ0w/CpiMkA6TS3hSCI3?=
 =?us-ascii?Q?nopiiyxIcnW08HFu2r6uGO5ZaTaSS9k+horwaJhPrudVyuuv2hlnQeim/huw?=
 =?us-ascii?Q?NKZlcJBJ3l4NguWOx1y/QrVKTdY64sGsu51XrsZKc95zIETpvpAjgdr3B6EN?=
 =?us-ascii?Q?KEDvmUZ42l97d4GTnn4bzjCWRxAMOC8Ik2CxVG4SWVgLqVwZ7V0rbSU5CXVD?=
 =?us-ascii?Q?/SGm69j+zvJyDvXM01NQ8cwAQ8BAVbJnZPgl1eVMOgfrUcOcvtkKfYe4APWE?=
 =?us-ascii?Q?EFWh4vIwFTJYIFsZ8NK3d8kqbq+4EYcEs06Iqp+WGLLMF5i4OShnuwvz5GN8?=
 =?us-ascii?Q?e7v23iK1tujoLsYd+lj/99ltBWUs5iKqPRPePMFHeSdo1pHhp2JBQXd/OX2N?=
 =?us-ascii?Q?a6jlv1pvK5/O/6EIFjMw/KjoIVhUyUag+BWtjTInKpSqHV2mlJRErqsogom2?=
 =?us-ascii?Q?Z8gpk5VDGjmVmdYK1dl3cdrqNCdSpR8tMNW8ZYO2mDkDSBFuYwKyNeMC7qoM?=
 =?us-ascii?Q?V/CX9Xi70KiATMGKbb3qcupj7cyNolZahbs9hgF9uQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jIcbFu7Uh8T/siU/2G5itixG+PfcitcGn1x/FuM0oj4SNmla5l9FeB7L3xF4?=
 =?us-ascii?Q?X8ALTGFX1WmMRqt0B/HETLMPUczVkxT/M41sItzorPPQWMSeFH4aMCwONXQ2?=
 =?us-ascii?Q?XESfJ9vkbIT3DiuYr7E3fb39ElENn4xHj/GVY/MDE7c9NNlEONAU7OoqcGN5?=
 =?us-ascii?Q?lcN5bDBUWYdu4ePYa/TDveCvjx5WARKVVbbBscfG+w+JujmCHIkEdtHDHorQ?=
 =?us-ascii?Q?p9xmWqUcTuCgzNlMzTAWE38iY4uxeX5pVQVKL93MMQsY0MQvwZ6eKTiYJPTk?=
 =?us-ascii?Q?FqqQY5SeRRJQHWq2rwnTRb25wBeTQt9Avsr30ta36DpgEzE9e4H5/ZYYOU8I?=
 =?us-ascii?Q?gI4uGs43DXeDjvo69c//O+Kknf65EUY65kQTStV5LkyzMsIJ78gRGj4f5AgY?=
 =?us-ascii?Q?hE3Us/36Dm9D9odfTvMfwaJ/1l0Euc/az7znmtwWaQunkNZnOGOs1g64dtFS?=
 =?us-ascii?Q?ghAGzvHfjw+ZvIvjYGS9iySMkcZwuJBg2udIMMCsoCVCUQz1M57F7LjVKAAA?=
 =?us-ascii?Q?BJ7fRgS0IDIRA5EXKwJnuEHlGDmSLxWuOiamspAHp0hvl42uFnlevOvbLNJL?=
 =?us-ascii?Q?Um0jwLBLWYTbTzFJLxVGP32oB1u+3bujE+KQNLn1HjH56+MLRPFal5ORouej?=
 =?us-ascii?Q?1RFmZHsu2liOKfJ58flO8N5diRhdEYSAQx9FuRypSF/4dprC1IZzdtTGC4mg?=
 =?us-ascii?Q?KSzy88xwJfN+lsR6mVf5tIyNaf/mlTqQgzy2yHt2LybHx7Hw2DupdL1VHqYb?=
 =?us-ascii?Q?l8vjOtzOlqJnoqxBsRb/xFQiHQ3YOm7OE1qNPIr2U4V76Tl/U5TRFNo23yrM?=
 =?us-ascii?Q?PQJSpR+DmAG27SfqTkvWI3pyBJ/m5g9LyXCjfZYDJnnbLv4zU7ruTW2z2Vf8?=
 =?us-ascii?Q?3iO6/jdmhAPHTAamP46NERxDLyQw8FD/y3tsbVWlxUPUxYNN6bmyp4FkDI+V?=
 =?us-ascii?Q?Vmo6UnaWqmMV++nqj7rUrUs1dvj0fEhtZchiMqzHMNiyectsNNla4w8iCTzN?=
 =?us-ascii?Q?BsaFcwTNV838Fj/SP3h9cWBhbukCjfk2z+lJmCcWZOoSvrFXtjr8x4A5UVsH?=
 =?us-ascii?Q?DXk8KIUZxA+xUBV+zloAF639QQqPkmad1UdXzLt1rb+L7GOFR7R8moVIUjEB?=
 =?us-ascii?Q?aPwg8HEu9Y+QgRP3N8HqdSevW7GDrGMlXdkv7mqlQYUWQh81vOFB6X9BhJ34?=
 =?us-ascii?Q?TjdwwvP3GMw6eY3G53ulNUsTbQzf6v6NEVpRtnQ+I3UFkqWwOZQ5i9I0wtw1?=
 =?us-ascii?Q?+a2G/RPclbeMQeodVYVFBFWplJa1+mjpcUP95ig8xYIxmBmizQaBRfqveOqt?=
 =?us-ascii?Q?1doMF+3o0DpqF0kDrFJ7sQ8uFYNlyfsFFsfrFqmnxxJVfJt5qUl/0zEG8jL6?=
 =?us-ascii?Q?E8Cf6M5T1PBllx0OeSTGmRoicdshirgY8oDQwSiR0cLjSwm85SFZw8BDqBlo?=
 =?us-ascii?Q?xXD6z/Tl6IZUCYN05hekIcS1+dsuVqEjea4BJqHhKqA5Hb5rI2QFeCgBv/Uf?=
 =?us-ascii?Q?9h3G5tFx+OmtxM/QvUR/oQLkQAX5+Ex8M95kSaDRj6e7osCrFC5d+jAaNkp1?=
 =?us-ascii?Q?TYtZvgK/4efCRuVGbKOcPGOCHac3lDyuHHlc/tQ0QuOf540BTFHaJiv5E65w?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n4gH/oaNpo9hLOYQWzvqDXPPch1/JPQGbM0i1GCEjCIBzR9OK0G3XaGbqY7RqLoInXh62byYkEIAu58+S6G1syTz09FAqdCpQ9gGAXJHzIJXbmGkFVnx3XEGhcHDcJ38yAdYDMwdb8+YABApZJk9+XlSnuG2rcK1H6PbnZbpG+El8GtRKNAotRj2MffIdyGbgo0rA6EtksmzsDHpuPP5aYScyd0N0vNFrtFV+DWv3pBgsRTKDA9b0LlSrkZQie1M73/nTQZOJCZb9QO+4brfxsx1BdkYT5Ys28lQ7TRgiiuFdTDWFNyUrtR1wJe05StuUbZaTz2dLKZA0F0WSf4Xc1Mp/TdzAqtHltKUmpNyhsTJEI2Yc3S/U5O7ERVOy0lOd3LY+Rzn6rTaK2XB+jVKw0AIW6K+ZTA90/Q6c7JcnOWRPcSfltg8HbxtmjlzP8KtZdhSSQkr8U7E80MHE7JMPGPeRxppKA4IAeJVeIJYdvXHddJ4hFrWftO1QSu7hRb+VqyjeyO3TD9o9nw76vJ8ijYeaUp9pjeFNJBp5J6XSYZRPLAWlcXBcI8BkYW4YSwp8LtwZ6ZV0uG0qcMpTHEutJKy4dvYDCHnXwlBFj7UAl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f787c6f2-28a6-4670-6f4a-08dcd94ce55f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:19:06.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl3pMOUUVTfZvIzWX7z0UKU1E8pP42BnO/4mntGkvDxFqiE7LlWjkvfnqYZ28z5fQcSPxP4voVcCpt6s6Xgc6yIv4xqUxMz0X+DALn7h/Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200058
X-Proofpoint-GUID: lsIHuohGZUWUcl19PqcxB9R56Bo79Hns
X-Proofpoint-ORIG-GUID: lsIHuohGZUWUcl19PqcxB9R56Bo79Hns

Hello all,

This is v2 of the series to add global variables to pahole's generated BTF.
Please see v1's cover letter for more justification and background. I've
incorporated Alan's feedback and added a forgotten Cc for the bpf list.

Thanks,
Stephen

v1: https://lore.kernel.org/dwarves/20240912190827.230176-1-stephen.s.brennan@oracle.com/

Stephen Brennan (4):
  dutil: return ELF section name when looked up by index
  dwarf_loader: add "artificial" and "top_level" variable flags
  btf_encoder: cache all ELF section info
  btf_encoder: add global_var feature to encode globals

 btf_encoder.c      | 373 ++++++++++++++++++++++-----------------------
 btf_encoder.h      |   8 +
 dutil.c            |  14 +-
 dutil.h            |   2 +-
 dwarf_loader.c     |  12 +-
 dwarves.h          |   3 +
 man-pages/pahole.1 |   8 +-
 pahole.c           |  11 +-
 8 files changed, 228 insertions(+), 203 deletions(-)

-- 
2.43.5


