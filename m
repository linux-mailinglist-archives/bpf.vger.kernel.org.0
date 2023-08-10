Return-Path: <bpf+bounces-7470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35447777F45
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 19:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035D81C2125A
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 17:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F24214F6;
	Thu, 10 Aug 2023 17:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57F1E1C0
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 17:39:58 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8DE26AA
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 10:39:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AGxTM8022432;
	Thu, 10 Aug 2023 17:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l2KfUUiPDHvAa+lAls28hNPKuUiTEeeq22IDWpP1R9Q=;
 b=uVvzuG+y2whRXuoMPxT/KltbQhygVGAbES/ATV3Nos2rRXlwNGUQHDcmM735oF5lAScm
 kyTVLwtvYOcigRm4JU3fHmEqMqXIwGCWldt6ajjvETNRAqj9wrsq150WE8FMIETOC/1B
 0Tz0JA3nL6I0gHao78Wytzk//b6/QwUDm3avrN2FWdgLUHDAlCWcZePX5048xtBf/r6O
 fZMON/XozxPwnm1gskguq9IlbgeMabaQxTFLcRgfODWXp2dTkbgnY6g9fuy+K+T4Uo1l
 ev3DnhR/rU9YVkdsSFOue7OuMUThTTOOGjGNwrsVtZTDbQdvjL7/bWwfZw38QaVzaTKv Cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9cueumk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 17:39:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AGI2eW002851;
	Thu, 10 Aug 2023 17:39:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv93gmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Aug 2023 17:39:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k78DcLiVqcuGkLYPlwvpGfy0pBtmAf0QvTzMSnvGShI4fTw7umGTqj4BylpywSZQlpcfvABlkkU5V4PsOx5K9PXFYykIDIfjJsKIE/mIgbr+ZU+JouPAcn/ukrmoK349LUW1RQPoMWFXCL7fe79/E2D0Vi+T4A0mQM8dK6UJOBnQgsQY8l4fTG1vNkHrKZW74F6XeR0ovZF8ll2MzrZPbcsWV3arYNHEdtjrJdYD51+aEhOCgGY5p6Ac71GDQyTg9tsC/X3XnYoM4e+XcdbrZajlWwbvea84B0TYgDVduYHieP4x5aPx90gzBDGp6VYdNxc3Ie8T0m9MuC8kFhVWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2KfUUiPDHvAa+lAls28hNPKuUiTEeeq22IDWpP1R9Q=;
 b=Bbl58J8vuYQMYigj4gRYSic7GQxUJfMF747zTEoun8D2HAO6gTzHY/pwI+idJkk7PTvvCRLs6xPpPBruMD5pU6UKcR3A4B73dK4mkJALXTpawCq6yIe8ADo5x1s93+JQhlU3YQA3QI8OwDkNuZtO2nDen9A8AeopStxGXKDbAefFQcwzNGuIVnBalYJnYrY5bnkQlQYalRHLGyKtg+qzqKuistcJtFUFfF1iiVip7/JThH3vJCVuIQ1AmRcX1hMgRihWbaq0f7uOStWh5IBp3oWqYED15l+0L1L8BjNV0+GESPZaRPp2ZT43CdTO7KGVZ1tZritb/SSI3FcaK349Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2KfUUiPDHvAa+lAls28hNPKuUiTEeeq22IDWpP1R9Q=;
 b=n8wopssWMYyQ81hB8W4CRedSFFgojLXFq/dh/0NOMbWYTEQ6vRDPD3v5Npf0KdUQpYOE4s95cMvH+Ov/94tEIZheKpImfrTpQPg4NE49tx/MJ90idC/wp3NvHSUPxLiA9p0l8kAq/W+aKkus6AGOQs4XIM+BBrJv8oIk9EHObUg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM4PR10MB6254.namprd10.prod.outlook.com (2603:10b6:8:8f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 17:39:44 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af%3]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 17:39:44 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
In-Reply-To: <a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev> (Yonghong Song's
	message of "Thu, 10 Aug 2023 10:26:46 -0700")
References: <87edkbnq14.fsf@oracle.com>
	<a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
Date: Thu, 10 Aug 2023 19:39:38 +0200
Message-ID: <87a5uyiyp1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM4PR10MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e43335-b078-4ab0-66ee-08db99c8c89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cc9zVSdut7tbHLhhE8jJ5nfgNBbH3H+OnRGPqnNn3yqSRacYvq7oejHyLsZ7uJbkTeFcqaOPBO5/rgOJYPwomOsK52eg0fOzKK3mUkpKh+Z/TFRt9F8klwi+qrcouam7twmqHDFkDnF5IF7LYQ7brvu6UyHxR5FKkZJgXb8uEAbGx4X6+C7+ZDTTadKG/M0mbsOJjXCPCAlpOYzJar28240JRTdyG1tYP5cAsDuCjQlFCIwGU6gCsqp2JSlqrmlS6wUJjcslzd9u2YAp/Vtdw8rUa8w+B4g3+VLS0XEf/nsA2GhAsiHtdTuIKQY0S4lrj67CEdVlU7yb/fsIrMDJATPmO8eed6x+x/vQxhSst6LgKAGqwCThYOfK1OHX7ydEXLiLgiNAPzKph6xSUBGmkgifJywvlm81mPcEPJLTWUFZIJinAv3+QZ2jL+Y29SDhvb08KZFThDED4tNU2M/X2+5E/i4rrPfoOkjyKJoKhbTxgIZNovZnaUZ+GmFqakhf/B9/bZePoAo0Agiu0PzEZdduFztewXz1lEClvkARlduILGP57wbFHJVushdXxt41
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(186006)(1800799006)(2906002)(5660300002)(41300700001)(38100700002)(53546011)(2616005)(6506007)(26005)(8936002)(8676002)(6486002)(6666004)(66946007)(86362001)(36756003)(6512007)(66476007)(66556008)(4326008)(478600001)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFlQRDhYYldxODZET0krMi9xYmhBQjJLSzMxY2dHWlFKSS9KcmlacHJtNGJw?=
 =?utf-8?B?YjdITEdqK1dmb0lpbExRZVVNUE01aytUY2U4QmU4b0RCOURYalgzQjNkUFdr?=
 =?utf-8?B?RVM0U0JjREU5cjQwb3Fra0VpaHFTcjd4R0N0bERxbnUrenhoZzl2ZjJ0UEVS?=
 =?utf-8?B?TGJSMVMrVDRERlcwdk9obzNlbnh2VmhkZUxRR291QmFnSksrVEw2cjlaLzg0?=
 =?utf-8?B?d2dPVTVKMGEySnhwaDhMTWFKcHZDT2h4MTE4ZmJpWWF2dUJHWnY2cmR2d0FS?=
 =?utf-8?B?Ym9MbnpYSHdLQ2Rrcy85QlByem5WQk4vcTNKTFFqalJoSmxUT3AzSDhSWlFY?=
 =?utf-8?B?STZ0dEZaOFhXbzZTUHdGNTM4UVkrLzNGTFovN2lHMmlKSW04cmcvRUhTTUVS?=
 =?utf-8?B?V2pWUTY0VnFLZFlYSnJHckRTcmgxdnZnbTczUzVSY0t6TVlDWVRSUEVBdmth?=
 =?utf-8?B?dlVuNXM1TUpFbHBCdUpxUkhlTlJkR01wZU9sb29tbjRZUFFzVHlBYTBRQmZY?=
 =?utf-8?B?dGJDVFUxOGJIcWoxTDJCeXcvRG5tN0JsbCt4by9yWjNaUzk5czZHVzU4bnB6?=
 =?utf-8?B?Y3lxOWdyTmJ2Mm1QSHErYnZrYXNnTUVNQXdqUDhhUU5vbkFOajVzTitWcXN5?=
 =?utf-8?B?MlN5NVBoQ01ndERmNXFFWk43S3IwaklJejhvSm1KZTVyeHBpZis3NUxLQkg3?=
 =?utf-8?B?cmlOYmRVenYrNHVyNlpYVWgzeTRETFZMT1BPcTFuUnB4MXREQ0ZtaUZQdi9K?=
 =?utf-8?B?WmIxVWU2TE5vUXlhUU14K2ZBWDRPdXUzdG95TTBTam14Wklna2EvaXBObjRH?=
 =?utf-8?B?ZU1jdlFENkc5NW0valBLNmNNb2g4ZloxczZzdWxTTktkQUEySDJDS1EzVTB6?=
 =?utf-8?B?VGZZSjdCYnhoempEOEx1VG5pU1ZBRFB2WFA1a29aWmtEelRWVGJ1NGp5djFE?=
 =?utf-8?B?SXhlK2w1NnEwZ3h0a1JTRGVraWxQT3NFMHRYUnhlWmxaVzhIRUpvaVNOb1o3?=
 =?utf-8?B?dk9ETUE4d05HZmVWZkN4N293dzlWQk1CRzhoak5iYUQxNHVEcFdJeUNRaWxJ?=
 =?utf-8?B?aXg5L3VoU0lKRjJjenkxTUJ1WjlzeThrVFNmMlVsR0xWVDBMKytwSlAyV2gv?=
 =?utf-8?B?TkZVWGpBODBkNnRXVmkySzhIWnRCdjNtaUhzSHoxOGttazZaYWp5RGdBRmt6?=
 =?utf-8?B?eHk4U2pBTFpZb2hOUWE4bnFRZmZ6OU5HVTZQVEFRd0ZleHBpTGJlQlkxMzlC?=
 =?utf-8?B?alp0QVlBbEVYMkNoSnBHeFJpRWZmVjdod1NBSjVTSzhEeHFTNDdiRXBhM0NU?=
 =?utf-8?B?bjcyK3F0SjBabHRoWTgvMzdHb0k2MnJNeU1DQndnSXhhZ25ReWRjYm5MM3pJ?=
 =?utf-8?B?Q3JBdFpMRnZ6dFpPRUQ5MlRhWmZHcmxtdnAxa2VIMTRzcE9sM0d3UHpXZHlS?=
 =?utf-8?B?THZWWGpEemJ1aTZWU015eWV2RUU4d2x1MXF1VG1oSTZxMnpFbjB2Zzh2YTNI?=
 =?utf-8?B?Wm5EME5SYWhyRDFxMDVhc2tva0JVTmdhbmdZZ1NsK3JHTXM1UEc3OUJMVTJk?=
 =?utf-8?B?TUg0NDQ2R2I5TGdyVjB1Y0JRNFdDdXAyN2ZtLzFSbWlyTVhFQ3NRSkpUSFhr?=
 =?utf-8?B?amFyZTA1TlRpdExtQ1k2ejBDQjNWNGpTTjdrUGJhSnlOOVU1cTNwMENIdno0?=
 =?utf-8?B?eTRnbm16R2pwS094Skl0K0ZDa2tFMEdjT2RJc3g4UnlRMVA1Mkc3eFFZYjhl?=
 =?utf-8?B?YzlCUkNlNVZBVmU2YWZwMC9uOEp2QklqaWlyYWhWWXB1N0I5WVgwT0I5dit2?=
 =?utf-8?B?cWhmR2QzQXNEZVdzbzQ0NzB4VUJNTlVhVFlGaTZyVmFlalFLTVdGdjlIbmpH?=
 =?utf-8?B?OXEvZDVhTHozWkg2NTZjUGpDNmlzSFZ4aFc1VmtyeEtlQlhxeUZTcDJsQ3hG?=
 =?utf-8?B?VVc2b3ByajVEN1p5MzJDZERrclh2THppR3RqSTRSdkN3b3dxUkRSa2Y2K2pN?=
 =?utf-8?B?YWVxMnhPYUdTN2Z0a0kyZWtRY0pCQkdGNUFXRVdNQkZiaGpta216OGVJZ0JT?=
 =?utf-8?B?TXBKWmRsd1U5TTdVN1Jpd21ZN205K0VBdmIwaHVvWHZ5VmlnSDRyd2ZQMmhT?=
 =?utf-8?B?VGc2dXhOVWN3QVI1NmhhT25MSy9wTEpOOGJMTll6dHliQnE4ZXNyVEJlWXlw?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fIHPCF2PmL4+vp6DJ2mLEeiNewwIMwtwLwDrcOEndj65H1WCo3RTv2BcsiNQzWlPBqBWEd7TiK1J4raldMV/CnPSFTa11LUpfmU47hdB37z+5HbOHj5GqeatDrbR9g8F5tSlpsVwFSnfXZtqTwo50P6Li/0AXMOdMb/eUBCyXm3gPfnQ+FipsOMKIEvmsaTNrG9a/xtsed4xYFIdHMpBI8fVaDe5gBik2j+f3LSHVKOdRZRpljPC1IUZ8avqqhuircbT4POkjjKjPsXBPeOjiU/FRfa8BipfYmZMmfQ+D+usvw6dcImDA+z8aGMxi3mQAnCF8+Ai1eKGJZb+toBV3F0gxhYJhSJUMpEKypaLlzAbuSbZ0pKQO2fyxmM45dYkYJQoz7x+icJ53hKY540Zy+eDOl14TX1pUQqdCN8Y4wimQRroU9XjNgihMMilMhm2I3imGJlBlU3NZnIsU7TQMBLcVJrSEvqu00krf65Y5VlKX5Qw3phG70Aiq9HwVQEsveDQEYEQDacKPVVtlsfQQp6ZqOkodfIVpAhRe1W4KjyLLINvgRAYHFZeTPDCfE2wnCDl2MvggfeqiWCXW+Ld4bomNitxu5CrA8LQGGFNWPzuxZJY8Jl8XsfCXsQ3KypjyLT5tWZvsxtnkjZr3EVHFDfi9WXFWzg8790ceU2uTkhugwC6kmiIXzqABmKlzctSntj/hkCVNHV+7Z/LnCUBA86e24udCLK0DtGiEgXOUMVwRlj/VX0UrtlKccueEoMg4vamimOl7p749pU2cw0nlruQZ70erW2afQW0+HfoGhkNE3ZRNDYpQpd4Ugbivgzv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e43335-b078-4ab0-66ee-08db99c8c89c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 17:39:44.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBqzHEjdLt1qxYnswOd1shZHsIJyrYShMH/tSR1ZFjiVgFNYR7jRmCGV7Rm4Pt9WSrbX6NstzjEq+mmIYVnPNhMcD0C97LFeiNcPdOqfllI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6254
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100152
X-Proofpoint-ORIG-GUID: 2lfCswan5l1GA1K1FQyyQABm9HzCXkCO
X-Proofpoint-GUID: 2lfCswan5l1GA1K1FQyyQABm9HzCXkCO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 8/10/23 3:35 AM, Jose E. Marchesi wrote:
>> Hello.
>> We found that some of the BPF selftests use the "p" constraint in
>> inline
>> assembly snippets, for input operands for MOV (rN =3D rM) instructions.
>> This is mainly done via the __imm_ptr macro defined in
>> tools/testing/selftests/bpf/progs/bpf_misc.h:
>>    #define __imm_ptr(name) [name]"p"(&name)
>> Example:
>>    int consume_first_item_only(void *ctx)
>>    {
>>          struct bpf_iter_num iter;
>>          asm volatile (
>>                  /* create iterator */
>>                  "r1 =3D %[iter];"
>>                  [...]
>>                  :
>>                  : __imm_ptr(iter)
>>                  : CLOBBERS);
>>          [...]
>>    }
>> Little equivalent reproducer:
>>    int bar ()
>>    {
>>      int jorl;
>>      asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
>>      return jorl;
>>    }
>> The "p" constraint is a tricky one.  It is documented in the GCC
>> manual
>> section "Simple Constraints":
>>    An operand that is a valid memory address is allowed.  This is
>> for
>>    ``load address'' and ``push address'' instructions.
>>    p in the constraint must be accompanied by address_operand as the
>>    predicate in the match_operand.  This predicate interprets the mode
>>    specified in the match_operand as the mode of the memory reference fo=
r
>>    which the address would be valid.
>> There are two problems:
>> 1. It is questionable whether that constraint was ever intended to
>> be
>>     used in inline assembly templates, because its behavior really
>>     depends on compiler internals.  A "memory address" is not the same
>>     than a "memory operand" or a "memory reference" (constraint "m"), an=
d
>>     in fact its usage in the template above results in an error in both
>>     x86_64-linux-gnu and bpf-unkonwn-none:
>>       foo.c: In function =E2=80=98bar=E2=80=99:
>>       foo.c:6:3: error: invalid 'asm': invalid expression as operand
>>          6 |   asm volatile ("r1 =3D %[jorl]" : : [jorl]"p"(&jorl));
>>            |   ^~~
>>     I would assume the same happens with aarch64, riscv, and
>> most/all
>>     other targets in GCC, that do not accept operands of the form A + B
>>     that are not wrapped either in a const or in a memory reference.
>>     To avoid that error, the usage of the "p" constraint in internal
>> GCC
>>     instruction templates is supposed to be complemented by the 'a'
>>     modifier, like in:
>>       asm volatile ("r1 =3D %a[jorl]" : : [jorl]"p"(&jorl));
>>     Internally documented (in GCC's final.cc) as:
>>       %aN means expect operand N to be a memory address
>>          (not a memory reference!) and print a reference
>>          to that address.
>>     That works because when the modifier 'a' is found, GCC prints an
>>     "operand address", which is not the same than an "operand".
>>     But...
>> 2. Even if we used the internal 'a' modifier (we shouldn't) the 'rN
>> =3D
>>     rM' instruction really requires a register argument.  In cases
>>     involving automatics, like in the examples above, we easily end with=
:
>>       bar:
>>          #APP
>>              r1 =3D r10-4
>>          #NO_APP
>>     In other cases we could conceibly also end with a 64-bit label
>> that
>>     may overflow the 32-bit immediate operand of `rN =3D imm32'
>>     instructions:
>>          r1 =3D foo
>>     All of which is clearly wrong.
>> clang happens to do "the right thing" in the current usage of
>> __imm_ptr
>> in the BPF tests, because even with -O2 it seems to "reload" the
>> fp-relative address of the automatic to a register like in:
>>    bar:
>> 	r1 =3D r10
>> 	r1 +=3D -4
>> 	#APP
>> 	r1 =3D r1
>> 	#NO_APP
>
> Unfortunately, the modifier 'a' won't work for clang.
>
> $ cat t.c  int bar ()  {     int jorl;     asm volatile ("r1 =3D
> %a[jorl]" : : [jorl]"p"(&jorl));     return jorl;  }  $ gcc -O2 -g -S
> t.c  $ clang --target=3Dbpf -O2 -g -S t.c  clang:
> ../lib/Target/BPF/BPFAsmPrinter.cpp:126: virtual bool
> {anonymous}::BPFAsmPrinter::PrintAsmMemoryOperand(const
> llvm::MachineInstr*, unsigned int, const char*, llvm::raw_ostream&):
> Assertion `Offs
> etMO.isImm() && "Unexpected offset for inline asm memory operand."' faile=
d.
> ...
>
> I guess BPF backend can try to add support for this 'a' modifier
> if necessary.

I wouldn't advise that: it is an internal GCC detail that just happens
to work in inline asm.  Also, even if you did that constraint may result
in operands that are not single registers.  It would be better to use
"r" constraint instead.

>
>> Which is what GCC would generate with -O0.  Whether this is by chance or
>> by design (Nick, do you know?) I don't think the compiler should be
>> expected to do that reload driven by the "p" constraint.
>> I would suggest to change that macro (and similar out of macro
>> usages of
>> the "p" constraint in selftests/bpf/progs/iters.c) to use the "r"
>> constraint instead.  If a register is what is required, we should let
>> the compiler know.
>
> Could you specify what is the syntax ("r" constraint) which will work
> for both clang and gcc?

Instead of:

   #define __imm_ptr(name) [name]"p"(&name)

Use this:

   #define __imm_ptr(name) [name]"r"(&name)

That assures that the operand (the pointer value) will be available in
the form of a single register.

>
>> Thoughts?
>> PS: I am aware that the x86 port of the kernel uses the "p"
>> constraint
>>      in the percpu macros (arch/x86/include/asm/percpu.h) but that usage
>>      is in a different context (I would assume it is used in x86
>>      instructions that get constant addresses or global addresses loaded
>>      in registers and not automatics) where it seems to work well.
>>=20

