Return-Path: <bpf+bounces-29599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FD08C33D5
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC51F216CD
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261F2224F2;
	Sat, 11 May 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9c5wnQy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nxop9E9n"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7B1CD11
	for <bpf@vger.kernel.org>; Sat, 11 May 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715462620; cv=fail; b=j0UYTBHz3qMEKpSdaLIgeHzZ+h3oFZujVDK1xYaelyuxErajdIxQWwm3K+apRrkDmEmBwPlpPGG8rn47YBbNFTQso/VGn6rR2MuTuu9yXIRNIkwY8K/lsy0O2HFWcFItlzlcd5HB5zUfDQFodnoMBcxZi7U9EESyiw8oPKOVhtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715462620; c=relaxed/simple;
	bh=hMxTsv65GM5YTFjrs72t+DOF0hPl1npfAziUHERIwUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CqsH1XnorcbhlGSlrSJ/FkXQI70NTAZzWANzHyLjB+5tPSEi9qpgsLdy477Xf2vjCIAWSId0m/Rd6qck2ogFkvu+70wgqL+iCoU1vX/NrlZtL6rBe8QzCaO9OB16/tUkJKCOzAP7KCB8XYDY6XSFigMFQ0cXbO95X/YdB3PHJLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9c5wnQy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nxop9E9n; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44BKrwHY028388;
	Sat, 11 May 2024 21:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2ykLGMBAPp8QlcEYEtIhhV3wafDfMbSKIkzL4BJTQAc=;
 b=m9c5wnQyPjpZu8svrmigSvc+WXGHmyIfIP9Kw7nsGDqEFamkaE4g+eK8Iftx842P7cBM
 MvvEZu3+raXt7CdOd0SxTd61ZlWAaFy5/5LAZHPBGd9Tv3bf9WRJbfcqKhAvkMbd58mf
 abmGLVf4gu+wyXWYXxBKMN/sWHCt8KFSfLuFwwDTuyqbefDWP6GiDVRE0XNBxsTphaGX
 OX9snJE5seRHVtrIdpKH8Avw2DByOlCsAu2TPks27Dg5mVHT0Tlvv7ozWYa/oYMyymIk
 kbV1dzcSvNAptOWdLNsmwYz1UxncFKsUYupiQbSR033o9JNjUKAYXW9aNbuAO0sbpyqU 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y2g3q00g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 21:23:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44BKneoS022328;
	Sat, 11 May 2024 21:23:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y44hhtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 May 2024 21:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFDlSGtO/JUi9wWtcJL2mKFxA5MuFag6oRp0A4uZyheBFSLR7FocUw9dKE1M13mAGMw+k4cLtPsUbPNbT/l8YnvNptbscEJ3NHHjmppVUECPsPOdt3DemNxwLpRw9xf+VOjjtUU6T9+cjnn75RaMxTxppNSQUc9aHqct9vyZxYDcBhr4I91prYzEI1m+R7eBceljMqKmivhxliKrARyt8fAqWRHP7mJgMelgOSFRQL8zk3H4cYOP2FM9tScjXMy1k1/wtyCpJnbK44hAFY176eiaAndP9XaIaSHdhDupkU0757ZPCynKm9/ILny67Bv5sHCGTLkPot8c9xFETwrtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ykLGMBAPp8QlcEYEtIhhV3wafDfMbSKIkzL4BJTQAc=;
 b=FPVfrKe22LIZBMz5YMOqUAIhAIgvIjMrB6x9gzzXTc7+euPQmVcPNagtsj7P6fi1y6zMb6l1kn1OjM/7IGs6CAwHVG6GtM8WPTddt1a+z01CG9qbmxaQyEMR2RFdxQCfYcTqZsGkNW79ONLxMIk92uODgO5iNqjwSxjzd68LJn+SrvmzNnbnRmA8XVlnz4aE6MqeX1nS1bVS65l6RrIApCKw8WoswIKtqsQReQOtNozFD6ywlX2jrOFbMBk0jJ3EaDMhRaZ5svBGSNVlkhNaZpN4KbFG8ueJCHYizkgTgBLpd9k4zH/rW//sW7Uv/c3r0zqY8P7MK8rxFAckIJ9UsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ykLGMBAPp8QlcEYEtIhhV3wafDfMbSKIkzL4BJTQAc=;
 b=Nxop9E9nMHXI9cIplzMZeolhga0Sq4F58XSQR71wY6lr7atjj2v7NxOty7TcKwegUpbUb/3+5nlxjRlU/RzVcYYILfw8GHqgWOG98KpcCCXa++4NzHUGb9YcqvPV+xcVPhk7knpayrhrYrmzyGpHmlk2O5s8+0b2+ecF6uWLmKQ=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB6958.namprd10.prod.outlook.com (2603:10b6:510:28c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 21:23:25 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.049; Sat, 11 May 2024
 21:23:25 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next V2] bpf: make list_for_each_entry portable
Date: Sat, 11 May 2024 23:22:43 +0200
Message-Id: <20240511212243.23477-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d52dc8-38c3-4f0e-3542-08dc720097f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rRmoVQ1xL4Ttyp6cgYL9QSIo1XvIgVfmaYzO5l/rBVHM1VwgaPakqz0pPsvt?=
 =?us-ascii?Q?13RqR1coObBbxqAiTck2ezuOe1fov4lXL+AyYLjV4tpZPA7y2N7rqKMSxlNl?=
 =?us-ascii?Q?UQ9tGj9/SXE48yk6cg5dsOSUT4BUpVTzMkpCwLXU0RrCY7jwKgps/dR5oZVr?=
 =?us-ascii?Q?qOyCBhXYHBiVa19lmTaE6Z4YZO2Y1xT82uNFhuAnfVA6s9IJnmFu5kKoEYHH?=
 =?us-ascii?Q?rzGCr/Yq6h+vVjWD8R6bB14Tf59abWqFeVgQlBAmVOF/dsYg/R9AN6YT0x4a?=
 =?us-ascii?Q?qDwaf+oTiIQCKvSXgl3o4JVHDvdlml08ruBIOvgz/FVExv3vBxbbAouG1xtk?=
 =?us-ascii?Q?Rmnbo2W7YiswlLSA0idijsDPGAW1OFTT6uFQer8HKelqS0NKfvaVmBz1Uhbn?=
 =?us-ascii?Q?6poqFPMDlSopK5M6GUzZOFul4hMYsdSi2zL7sokXpYCYO/uhnEoKB++oCxUo?=
 =?us-ascii?Q?lMwyjCHjSo0r0npccxo3RFuR8HLHGE5xSUR12VbY3FgPgX6XXvynXe+0z5DA?=
 =?us-ascii?Q?QVkjK5ifTx0qDdmB6iLqL3yi1OPtEmQv/Yzq2wLSf72L75uoCZyf3dC7iLBD?=
 =?us-ascii?Q?hIdQhUzU/HUrykH7KXJMiAjDtMHnoReC4XiUlrbwGM0IUPka3YRQh+Tx77DH?=
 =?us-ascii?Q?Wmx4EkhbtRkviNCliCUibS41ZuSwqu65MRNAOkQTBO6C/nPmkNAV1kYMw99d?=
 =?us-ascii?Q?EvkcYCkICRDOxN93XXEnGfHcfQ7TyKDO7FfmcQFiPx8Vtf94WZFHXLB6Cqx8?=
 =?us-ascii?Q?mf7gL4FM/I+Ns5nXkDsUHcA+ymBpzEaP8n9aExIcD/a5zhZOJUoNdvxoniIx?=
 =?us-ascii?Q?mrtwO15I4onWs1jC88TS2Ab4Y+XOSQ/4Vzu7yIiNxJnqU05eS8o8vutiyDTn?=
 =?us-ascii?Q?XvIWlUblgZJPVITKHi15tU7J4NZyf9ZTBkR12ypIfxHHuyJt2MkfIno3uzMg?=
 =?us-ascii?Q?hS7TZPJADrq2jIFXQcj1uqEKrB9FHACk6FPp4f/EJOFJ7X8o35lZtuRZAFqu?=
 =?us-ascii?Q?9YCgH3nTVsU4r1EJHA+ubjgU2ggp4S9WTxW1eoGAhEsAtT8b+rgn19dAscS2?=
 =?us-ascii?Q?tSecd+cPmwg8hldefEoPFk4G9iqg5PKRNP15BDo38PHANf+w70LqVzCacjDv?=
 =?us-ascii?Q?fWQ7TIQUnFW5WTq8yOhfgZPQAWeaxkv9q088M+6U/AjkxL3KIumUG0QtJZqc?=
 =?us-ascii?Q?3KxTPZl2qsdh+YG3yXqwLso5zemkNcC2Sfm59JvH8ExOrln0zGeqJ7nSCFS/?=
 =?us-ascii?Q?6Wj8boJ7WRXtbyZjyMINUqacc3cxlonwgQbS2+tGTQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RdHuPAFIw9+1ZGoQY67PwMH/x8V76zwP0KEQkj5fqNYvTdDmskensEHVh1yt?=
 =?us-ascii?Q?coWOU0nr87FVbc/PoW5Q4OCryDcEdDMyvJGJn+Et+/bNg2w0PGUOAkEYoaCo?=
 =?us-ascii?Q?5DbC6MWXDfOX/vRKZLGoo61TFG+KgHU/kG0CNHTUShrtgvNZIXgIuOEW7t04?=
 =?us-ascii?Q?18YouskdbBT6RyadTKN9sEjT6MaYjGRBBEUsg5X9HfbtHO9W0/Lk+cZvDsM+?=
 =?us-ascii?Q?ikaBm+2BjnLv3mJwql9g8UP32ZIYgLOjsl8dpCbs0sDi5zs/cven6yJuau/V?=
 =?us-ascii?Q?4yTjXGkN6l8RHh3dOYTVvZ22ukkIK2oYQNAdqwakfhqu25l+PesdQSeY2HXm?=
 =?us-ascii?Q?lCGvU+L8fuyfz059K21abDbxilirWcA30gC0quQIpC7ClClZJqbfMxMS89Z/?=
 =?us-ascii?Q?H0eCVHbASnJoYFd774DLlkFdlFuRn751TcK9VSgrwhyE0PC8Jsok7uKD0ElB?=
 =?us-ascii?Q?RLomxfzEQoU2xCTw8vnfXhcx7szp8mBXUYf6j541zY1yZdeeNiww5AGTZ/pL?=
 =?us-ascii?Q?JSq1/vhSJ9R7Lv2gxuwWuesIQcS0lKW1aaELp4OOHROvNyEdWYR1rSLKwzFk?=
 =?us-ascii?Q?HT2C8BT6BPpii/VeWqPX/3TacYxKXaPiminU3Jt5UqIdp2wkDczvCPd25hg6?=
 =?us-ascii?Q?H+SwZgEVI+rxQrQH0FEdZTinj9MR0kDAH0bWbtXoFz8DIfMADpum0hP+O+4F?=
 =?us-ascii?Q?yh87rGz9sZTvk58nJDKtonbT8uoEaPnGgnp36BCxOUvxJoDyjWaLY0MtN7V5?=
 =?us-ascii?Q?E4QFef7RhP76OivV33dLYfnYayQ7k/kKm9cffMj73x/sTVrskJCf38FQnftf?=
 =?us-ascii?Q?MjyClfR+KJrtPDj7RPciWv4vbLBp2gqqJ4R7F1U2s8/ZlTeDDtTzYWPV3cS5?=
 =?us-ascii?Q?5x1hA1GVAjaXQ+lB4iL/giHxP4kfqN1UqkF9foENDqeOzD/2/kUAYXcU0yG/?=
 =?us-ascii?Q?0dXDBKkpVVP78VXHdfcflqrPvhtaZo7mdrGl8uKuf4A+Dm98uXRYaH6wYxIA?=
 =?us-ascii?Q?eDGW7upPfm1Q/nCopF/3j/b3VT0EjFnvUC+tJ54XLxKnP/kDpzk7Q/CwzwZY?=
 =?us-ascii?Q?hgGqjEtd8w2UGnOg4tsvGr9NfPOOXuNX9frC1TNNphAUfaMkOWrRh7z/YAde?=
 =?us-ascii?Q?h0Jv8U3R8KcIGlVHXpX88WSCDivBLEYWLVk23mhRPg7/FUow2ukiuUrKZeaE?=
 =?us-ascii?Q?9e/PeJVsBVTouURQqYpbCB8IKHTO/HB8YEq7/+ozbjigPpqhfzCYcZ1/n9Nq?=
 =?us-ascii?Q?lnfwRUJu4edCnDLHln/NrX0FzWvzK6zFiPTjhQ962NbOzGA3acocRG85lBl/?=
 =?us-ascii?Q?l0R6Q5X3lvaE80oleSMTW1xGKi7Vkg+86uwAgcQI0MWXDxjvZpWIWx9XJ/dh?=
 =?us-ascii?Q?FcKweCiCitQ0J1blfz4x5XOLi+O7lgLzneTZTujUeh0426NwIsvvAnHTS3mT?=
 =?us-ascii?Q?qPFc3NeOWjDJb/7oHRg4cmv5OXTBVgRkfI9758UoHpycloNSZphzpkJPMpcX?=
 =?us-ascii?Q?hLevAcjT1er9raYQmwgOMV1t1wLPaNfxzE+6WdUyVNQNNigLVhRhnUdiD5Ml?=
 =?us-ascii?Q?zQ3lZEm3zKkCqJdt8v4SFeNglPQbXswwsPiyvBXZGWDdO0I0ITFFruwnxPXB?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HJW/Tr1nxUqvaP3l1Re++dTjwoirsyMHghkBfqkAmM3Ew5c4t+9LpHeyLrP1IfOEFTW8ZP/eYfaNTxTtjn2bJh69QM2Hfedq3VN9fPp8X+r6m+3ZdCXMAVTFi2Lm9/bn+wY9llUx1A77/uSivePbxjWOsKZkmyBfgol0c5Y9qaX0yd2ka0sYvjj5e+HtfZGK12d5Z9Kz0mY/oXpVJKsBqQ6DHXCBg37kZLGoLj/HW9IY51BWt1w/BbTxZdE43M0FHIvIna2/FgBjZe90Vlgl9E1FCV5t28dyd6+wW70CiVQp9b7VuVCcAovGkcou+jpX6zytzNi81/lt/pZ7D86NN1gwIcbMiIuiJ345UTd/bXFPeMu5tXWhKePUptqVUFeQLsjDFR8n8qH+Wf/J6DM3E7/BKjeileJBrIN5CQDMgorCBtD0UP9HNweBXLWhVKmntSne8OR1mq1TRnqLvJ7mxtmDYGaJzfV8WCeN+YCug6/dBI9KVcLdhn/hEkle7sVqcjbnb/tPFZnhtACkQQURvUUXWc7qUfDNOhO+ldieZkgGbBAbacIvdqYh0BWoAaEg+W4uu6yKwElSOHSMFSiRaURAf321e+q/iX3muu59xJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d52dc8-38c3-4f0e-3542-08dc720097f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 21:23:25.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8F9xvtb7FxXs29uKgJg/nl9Y/q096HYB07NXl5iTVLhVzdl7nPh0hE5g4enZ+lfzEfv1TSzRi8ie4H5ZKmNAi/MDSg0/juxv0vsjFwNBt3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_06,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405110161
X-Proofpoint-GUID: RutlDIDxWZ2hF0VL-gyGHrF2Lxg5BBSb
X-Proofpoint-ORIG-GUID: RutlDIDxWZ2hF0VL-gyGHrF2Lxg5BBSb

[Changes from V1:
- The __compat_break has been abandoned in favor of
  a more readable can_loop macro that can be used anywhere, including
  loop conditions.]

The macro list_for_each_entry is defined in bpf_arena_list.h as
follows:

  #define list_for_each_entry(pos, head, member)				\
	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
						    typeof(*(pos)), member),	\
			      (void *)0);					\
	     pos && ({ ___tmp = (void *)pos->member.next; 1; });		\
	     cond_break,							\
	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))

The macro cond_break, in turn, expands to a statement expression that
contains a `break' statement.  Compound statement expressions, and the
subsequent ability of placing statements in the header of a `for'
loop, are GNU extensions.

Unfortunately, clang implements this GNU extension differently than
GCC:

- In GCC the `break' statement is bound to the containing "breakable"
  context in which the defining `for' appears.  If there is no such
  context, GCC emits a warning: break statement without enclosing `for'
  o `switch' statement.

- In clang the `break' statement is bound to the defining `for'.  If
  the defining `for' is itself inside some breakable construct, then
  clang emits a -Wgcc-compat warning.

This patch adds a new macro can_loop to bpf_experimental, that
implements the same logic than cond_break but evaluates to a boolean
expression.  The patch also changes all the current instances of usage
of cond_break withing the header of loop accordingly.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
---
 tools/testing/selftests/bpf/bpf_arena_list.h  |  4 +--
 .../testing/selftests/bpf/bpf_experimental.h  | 28 +++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_list.c  |  2 +-
 .../bpf/progs/verifier_iterating_callbacks.c  |  9 +++---
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing/selftests/bpf/bpf_arena_list.h
index b99b9f408eff..85dbc3ea4da5 100644
--- a/tools/testing/selftests/bpf/bpf_arena_list.h
+++ b/tools/testing/selftests/bpf/bpf_arena_list.h
@@ -29,6 +29,7 @@ static inline void *bpf_iter_num_new(struct bpf_iter_num *it, int i, int j) { re
 static inline void bpf_iter_num_destroy(struct bpf_iter_num *it) {}
 static inline bool bpf_iter_num_next(struct bpf_iter_num *it) { return true; }
 #define cond_break ({})
+#define can_loop true
 #endif
 
 /* Safely walk link list elements. Deletion of elements is allowed. */
@@ -36,8 +37,7 @@ static inline bool bpf_iter_num_next(struct bpf_iter_num *it) { return true; }
 	for (void * ___tmp = (pos = list_entry_safe((head)->first,		\
 						    typeof(*(pos)), member),	\
 			      (void *)0);					\
-	     pos && ({ ___tmp = (void *)pos->member.next; 1; });		\
-	     cond_break,							\
+	     pos && ({ ___tmp = (void *)pos->member.next; 1; }) && can_loop;    \
 	     pos = list_entry_safe((void __arena *)___tmp, typeof(*(pos)), member))
 
 static inline void list_add_head(arena_list_node_t *n, arena_list_head_t *h)
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 8b9cc87be4c4..13e79af0a17c 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -326,7 +326,21 @@ l_true:												\
        })
 #endif
 
+/* Note that cond_break can only be portably used in the body of a
+   breakable construct, whereas can_loop can be used anywhere.  */
+
 #ifdef __BPF_FEATURE_MAY_GOTO
+#define can_loop					\
+  	({ __label__ l_break, l_continue;		\
+	bool ret = true;				\
+	 asm volatile goto("may_goto %l[l_break]"	\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
 #define cond_break					\
 	({ __label__ l_break, l_continue;		\
 	 asm volatile goto("may_goto %l[l_break]"	\
@@ -336,6 +350,20 @@ l_true:												\
 	l_continue:;					\
 	})
 #else
+#define can_loop					\
+  	({ __label__ l_break, l_continue;		\
+	 bool ret = true;				\
+	 asm volatile goto("1:.byte 0xe5;			\
+		      .byte 0;				\
+		      .long ((%l[l_break] - 1b - 8) / 8) & 0xffff;	\
+		      .short 0"				\
+		      :::: l_break);			\
+	goto l_continue;				\
+	l_break: ret = false;				\
+	l_continue:;					\
+	ret;						\
+	})
+
 #define cond_break					\
 	({ __label__ l_break, l_continue;		\
 	 asm volatile goto("1:.byte 0xe5;			\
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
index c0422c58cee2..93bd0600eba0 100644
--- a/tools/testing/selftests/bpf/progs/arena_list.c
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -49,7 +49,7 @@ int arena_list_add(void *ctx)
 
 	list_head = &global_head;
 
-	for (i = zero; i < cnt; cond_break, i++) {
+	for (i = zero; i < cnt && can_loop; i++) {
 		struct elem __arena *n = bpf_alloc(sizeof(*n));
 
 		test_val++;
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 99e561f18f9b..bd676d7e615f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -318,7 +318,7 @@ int cond_break1(const void *ctx)
 	unsigned long i;
 	unsigned int sum = 0;
 
-	for (i = zero; i < ARR_SZ; cond_break, i++)
+	for (i = zero; i < ARR_SZ && can_loop; i++)
 		sum += i;
 	for (i = zero; i < ARR_SZ; i++) {
 		barrier_var(i);
@@ -336,12 +336,11 @@ int cond_break2(const void *ctx)
 	int i, j;
 	int sum = 0;
 
-	for (i = zero; i < 1000; cond_break, i++)
+	for (i = zero; i < 1000 && can_loop; i++)
 		for (j = zero; j < 1000; j++) {
 			sum += i + j;
 			cond_break;
-		}
-
+	}
 	return sum;
 }
 
@@ -349,7 +348,7 @@ static __noinline int loop(void)
 {
 	int i, sum = 0;
 
-	for (i = zero; i <= 1000000; i++, cond_break)
+	for (i = zero; i <= 1000000 && can_loop; i++)
 		sum += i;
 
 	return sum;
-- 
2.30.2


