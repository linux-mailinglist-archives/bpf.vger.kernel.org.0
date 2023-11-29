Return-Path: <bpf+bounces-16131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A517FCFBB
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 08:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1A928275E
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E54107B7;
	Wed, 29 Nov 2023 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CeD72YtC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y64wH5d3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194F10F4
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 23:08:54 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT6YDai004772;
	Wed, 29 Nov 2023 07:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WENArYNWF/DKsfEMxTpyH5QG3dcewucATTAyjM10EzI=;
 b=CeD72YtCCKY7gyImFtiMkPoWiFOZPV+DEFnObSbVax/7bVi+/Tfe4WQ5lrLVEBpMnVut
 +jo/PJe74h8Sm7O6NC0ehEaUYWuPsDN5blQbiTulTp2C4N3kPMAJSa2WlA5msm0q+l2e
 1bp5Ej1SwvB/F6YT5qcxhjyo+2qLUDCm/jzaiY2f+biKiED+vHTTfJfQCE2wRN71AsE+
 1cK2ioM/Eilpzjo6i0mh0nJRmEv4QfMsvV3gip3bUi+FEceo4GwL1lF2Lo63iA9VYQ7s
 wBcp2io4k9DB17+r3Z+MSxyaWBccvWCWO52qUJTi7jG/m4MdmfV9GtQsbXN/38qh+1Jc sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un1rxkv0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 07:08:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT64vPH009238;
	Wed, 29 Nov 2023 07:08:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c7uy83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 07:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk0bWlH1wTc9ltfPOEb/KZQmkuOMyJ/VylwMnU1pV6vilPnXcHMUL4w7AsS5rlryjLt1k4FXOCFbNNBiav4qBE21hFl1FtYnlysglAxf5qehD/N6V7gC/IiQODXtaA4f50670h8SPD9DAHGcCiZRyH9f6g3YfaCfiR2AtorLqaV0st37Z5gFDKHSO1qna9KRdOcdrVhWsKh2zP8cen9RAdJqH4TfWhokfaemruEOQq9Scq0s7ccWazzdsKL6eeokOKWNFMuiZfDO7YXA/s7dahQGHouHNe+suuwGPpRgY9b1ioZMK7VixREtu/9rOcqoxd8c7D/S7+SFESXEgicRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WENArYNWF/DKsfEMxTpyH5QG3dcewucATTAyjM10EzI=;
 b=YPldzfTIS2LJ64wQ/+WXx+V7NzgmpZrjD5UnnY+fp5p3ZXkpffD43YnwtpmXD7ewg59HIrGEObomfQM+m1DB0hZ21ucKYXagmQh56jhUQwRjBgtD1bnYOO1Y1ORuwdVrUYJyA6cjc82ihk5TtqwVB9mD8IU4e/HoEZAcJJKuqRWxxNg4IMIZjrU9Tqg8Q3sFTK9Eyoc2kV/20P0jdlJkZajgNBzLWh9hs0sG8VgZtMeeqOYaqlXhniiwBOpGBEn7fDr7eVGaeLNu/2gr+J0KdkmQXlH1FH7qK5GgUQLhjKLh+bN/TKX1nBoRcjrRncYUu381NTDzhaG/kHHtM7OCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WENArYNWF/DKsfEMxTpyH5QG3dcewucATTAyjM10EzI=;
 b=y64wH5d3rkpMdTHtLF4e9EmO8q6MB5rc8ohbb8990cHU/GJOGZnvwHLVcByY/ZcwMDDhDqwpYknqqZPxZ58MG1VS1VJQQIqD25L3Hg44vxQtTcds7mSTvzjoJ2lOKOqLhapjJr0bXf5AymdFYzPLCas3Ph4i209XuY+0lusbIWY=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB5926.namprd10.prod.outlook.com (2603:10b6:8:86::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 07:08:48 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 07:08:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: BPF GCC status - Nov 2023
In-Reply-To: <3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev> (Yonghong Song's
	message of "Tue, 28 Nov 2023 21:50:59 -0800")
References: <87leahx2xh.fsf@oracle.com>
	<3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev>
Date: Wed, 29 Nov 2023 08:08:43 +0100
Message-ID: <87jzq1t4sk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac204cb-9803-45f8-9dd3-08dbf0aa086b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1Qg+djpJp1OaEAMHDCPoWAkpvg3TpXts7WlT1U/qfmwyEHqxH0OfgpuI0F2b8cDQey/PGJHzuBWYsgl7dyRlZqtONLH5jMJzzBqzG+zGhVuNVF86LFNc0LghmeUvrSYlsP9xWKXE29JNpysAmFrSZLovFVE3fShyG7YEMahQDheUmDZEZ4th+p+MhdDRLGi6l4gaiaDNmSrcPdhqcGAwjMU+yfPullKdrKq/yCfU8DQPE8+6p4RfjrSjGe8fmhJLcdBRuWCf+YrjpjCx0fwSZdqVQmdYyJdOae8rf+7kB5j0zHDXHOrxeLmARul4FeReVDCiSpRwWphWa8RX3WMm0HCKlFtdvpyNm2d+aA3sXt7RlqoC8QrbtdgWoAEcT96Nhh1Lhpyb12nrmHGouHVA2AGa2eENtfMHG7dfIu1GeHLd7ld7AerJIedur0KbUIn7acYfYi0CzaQcYSoeH4gaNosPEeZ/Cw+f3UCygmVkKsfuXO2woKjNBnHChDvC2YJgGosdd7p6IG+iIAY/sSaA00RQYaJOs6dxs3fsx15Teg1x5ZdoxeDchN746TmTPOp7cSkjZ/5cgEnrtVJj2JcSjOjapPv/NTKBOJ1VUGRuXN9ROdkuTg+PdxQqdruKpxMH7bvKlOWhn6w7Omr16WcC0Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(38100700002)(8676002)(4326008)(6916009)(6486002)(8936002)(6666004)(53546011)(6506007)(66476007)(66556008)(5660300002)(316002)(86362001)(966005)(478600001)(66946007)(36756003)(41300700001)(2906002)(6512007)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHk0NHgvejJUZnJxZUV0cXM1QU9IOXlkMUtNenRPZUhXZDM3dnN0NDVCbUEw?=
 =?utf-8?B?SEpYSy92ejI3Ylo1R3FtY0FXb2JQQld2cjdia254RWJrOWlSTk1LSCsrbllQ?=
 =?utf-8?B?VlRZUmg4OHh3UzdCaFpnRUhNYzJ1MCtxa280TU9PSURucnNwTkNpUG9ZQnU2?=
 =?utf-8?B?ZlZWVlFKaHlFR1dBMmNyRlJudE5xMEFBMFdxaEpUeGNFdVdsazNROXQyRUR2?=
 =?utf-8?B?bE9oZnR0UHR4SzlramVSRVdFVzdyWlRiRElNcmVyLy8rU0tWc005YnFaWW9R?=
 =?utf-8?B?SElqWVZBdWpFSDdPa3JQODBPL3B1eXlXUzR0UFkwQ3h5VzA4OHhGMi9XM1dZ?=
 =?utf-8?B?K0c0ZXJpbk1YbFJOb3lWaWt4VkZUN1Z6cWJxVmgxL0J5b2E4U1ZmR0ZOeDh2?=
 =?utf-8?B?TWwzZTYxTXR6MHpLRnFhdWFpV291dUtUb0lGWWIxSXIrbzhYajBhbkJ0NlRC?=
 =?utf-8?B?VWpjS28vQXVyZ0F5TzcvVUg3bk5yOTZaZjVsSDdON3hBUHF4ZncwSmZMRmxq?=
 =?utf-8?B?L001ZjN2RUY3a2Iya2ZBRUdjMTJERzhPdTJlMDE3NWVvTG1HWmJEM29LVFVT?=
 =?utf-8?B?ZC84T0VONElBak44MnQ3Q05hLzdrZEZ3UC80S1VXKzh6U2Vrbk5JQSsyb2wv?=
 =?utf-8?B?M0pMSEJWZzAwQ0Q2b1VFN2VpWTBYRW1oR0J6ZGZDNHRsQ3dNM0RkcldQZ1VK?=
 =?utf-8?B?RFpWbmdUNWdXUGpUVmFtL3FZeGE5M0haZzJYdDVKNmVrekdLdUFPZ3VjWXhE?=
 =?utf-8?B?ak51aVk1cHhOVzg4SHVhazRMUHIvekliQ21iSWlVZGxhWE1xbDJmYkZVZG1m?=
 =?utf-8?B?R1N2K0UwUkNPYXhUcWZXRDFRMXJXSjZCM2lid2F4SmdYalBLVDRtL1NRWkQv?=
 =?utf-8?B?dTlWaVJ3ZndNQlU1Q0YvUG1kWkpkK25SM1NDODZ5VE1HZFV1cjZuSnhvcTZq?=
 =?utf-8?B?Q1pSalZkbTdvdVltODR2OFJCLzREU1EwcG55cnJha2J5K2hwaXhabHphZmM3?=
 =?utf-8?B?Ty9GS280MXJydzZVK3VtZWpnQmdCbHhrRWd6V01oZlY5c2s0L0FMeVUxSjRG?=
 =?utf-8?B?RDhvR0lxKzZCR2hqTkNYcEQyRlh5WlZQVEhjK3h1UFdqSks0MldHbncvZ0NK?=
 =?utf-8?B?SXdTSVVGaXJaY1BsRGFuMS91eFY4aGhEZWwxQThtSUtOOE1MSDRoN2pqUG5O?=
 =?utf-8?B?dCtyb1g2U0pHeElsSXZWQTdVSVdxN3ZuY3MweDY5cktZVXJQclhpTmxCLzRN?=
 =?utf-8?B?enpuZHJoaVVwREFRdFgrK2V4cDFiQTNxaC9RSFE3NXlmaWoxSCtQellTejJQ?=
 =?utf-8?B?RStORjdVWFNsUk8xL1I4L2ZnV25Fd1VpVmhvNi9MU0FNQVRDMjFCVkhCZy9T?=
 =?utf-8?B?NlVaS3ByZFhpREhILzVDZFA0bW9TMjZvT05Makg2Qm1sTzhieDY2WHNMZ2dQ?=
 =?utf-8?B?bkd2ZXFmQTAxZlRyQUE5QmJYMmlEZ1B0UGsreVZ0cUlHdUtpZktmUGdZMWFu?=
 =?utf-8?B?L21vYmFzcndFQTZFTlJXZkJ2dURQMWlWejlGYWNaK0o1N08rSHltTXZLN1ZJ?=
 =?utf-8?B?MEN3V05rY3NLWVBmL093OHNRS2xiK0szdFJMWGRGRG83TkxZeGtlUU00NEov?=
 =?utf-8?B?aHBsWWtxSHpRY010QzF6dFMxY0pxRThPVXViWlNiQ3p4cS9uUmkwKy9ZaXgx?=
 =?utf-8?B?TzFsQUhLNUdsSG9KZEsyUTV6eGI4aWd0RGJpZ1VZWEQ1c2l0V2FMaXpaYS9k?=
 =?utf-8?B?Mm5udnRVdUIrMGZEdEYxNldJWEpicUQzdnoreHJnSUtIMUVLTTZjOHIrcG5l?=
 =?utf-8?B?bFIwclhRYWJmdndRZkovZzRNTjhCZk9qMTNTcEdTczlzUzRvemgvSWQxQ2lT?=
 =?utf-8?B?RnI5NlhGTGp1QlpEbEl5czhmZzVEWjU3bS9qOGhDUFdwSFRrSGlKU1IySmpF?=
 =?utf-8?B?MHlSZHRnWmk1aWo3OVFCVmRoemczVk53Q0JVVFlRc0tBNWZZcytHOEdDUHpQ?=
 =?utf-8?B?TU1Ra2lsdHpWUy81cTNBUnhxT3VlUTFJOXNBZWlHeVVqRFNqNllSeWtaeS8w?=
 =?utf-8?B?dE5PeUJJdkN6WDBxa28yV0hWcldrQlZQdFgweVNuZ3ZWNVlTUmUzNWxQc0pz?=
 =?utf-8?B?azhFL0ZzemJoVm5jRmhOTFJmLzQycXFGQkVETERNNStJbERGeFEvQ3c1RW1W?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0oQ1LqFSd7qACLPqiRB0qUl71s9i9vquT6ncRNQK6yfLuyAt2zRrXuZKpmvex0Qx7fG5RJAODGgGEbbqd5dTnhnbets9+tqlqDVRI++l8w/ypKFnoCXqVgtieqvudzQVanpcwnEuYVy+TX8l0vXiJJx3/svLGvqRybfiH121m7Yc5Li4RHvTAlhXPUv45Ejaq0LptWYZDP4iEOP/ZtHfb2XJ77ZuxeLXRTSV32DjwACvpRxIQjnh56M5KSxWi2XSrCps8FkcK86Mr/0oNsBKjv3901T/OLwxfY4fvJYOGbgxJwEWtiayrb5xCgBPm8uXcouJ5wttth8vRgpeK7Q1WqS4yIglJaKsVPzEC9pT0vspc/MaafIqR62gzIomgkSw6D6OnjV4VnkUAKDCxWZ2+w0HYyFotwZ/6UkDlkG1p61CFS4s7HNTBp501Vz8LIk339oXP4xl3RKMP2wXna32HW/3UQOu0X+kRqoSzOfdWQGm1UF8bZZqbZyElZFs6EiWmlxgs8RNthxYKX8CrKiD/AKiapq/b+ZaBBDogvagn190+g3vY8/ItpDySXKdISn1VypKCtu4I+40KPxGYwKncytac6P94mo0Y8dqe17j8yuPAhtKT4zKu7E1xytF7EYPLWb+a4FbUJxm27IjJcA5VVQgtSpDsFAt0gIXOrsoKsT0xoccxU9c6EDLj1OojwInYqY94/S0hHesaAbipjbnyD4IK5UjE/UBmgqy/0rltRstY8BtAuyRBdNkjXDvsq7b4dcr0ZSYuhODrQUc4PISoiMaEEFiAhS6MXQPQ8KmFcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac204cb-9803-45f8-9dd3-08dbf0aa086b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 07:08:48.1784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYzi60qP9bsW9VOlvLl/10JO3JVMf0jh01v442OIo0poI+kXq4W51QgCta6gZ2WYAKo3YopP/XGlKsLL7xKXtX9rianPrQwMb6osGfhaIEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_04,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290051
X-Proofpoint-GUID: 3j1gOOU-O9gUJH6W8TId6dFETevWZBvO
X-Proofpoint-ORIG-GUID: 3j1gOOU-O9gUJH6W8TId6dFETevWZBvO


> On 11/28/23 11:23 AM, Jose E. Marchesi wrote:
>> [During LPC 2023 we talked about improving communication between the GCC
>>   BPF toolchain port and the kernel side.  This is the first periodical
>>   report that we plan to publish in the GCC wiki and send to interested
>>   parties.  Hopefully this will help.]
>>
>> GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
>> IRC channel: #gccbpf at irc.oftc.net.
>> Help on using the port: gcc@gcc.gnu.org
>> Patches and/or development discussions: gcc-patches@gnu.org
>
> Thanks a lot for detailed report. Really helpful to nail down
> issues facing one or both compilers. See comments below for
> some mentioned issues.
>
>>
>> Assembler
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [...]
>
>> - In the Pseudo-C syntax register names are not preceded by % characters
>>    nor any other prefix.  A consequence of that is that in contexts like
>>    instruction operands, where both register names and expressions
>>    involving symbols are expected, there is no way to disambiguate
>>    between them.  GAS was allowing symbols like `w3' or `r5' in syntacti=
c
>>    contexts where no registers were expected, such as in:
>>
>>      r0 =3D w3 ll  ; GAS interpreted w3 as symbol, clang emits error
>>
>>    The clang assembler wasn't allowing that.  During LPC we agreed that
>>    the simplest approach is to not allow any symbol to have the same nam=
e
>>    than a register, in any context.  So we changed GAS so it now doesn't
>>    allow to use register names as symbols in any expression, such as:
>>
>>      r0 =3D w3 + 1 ll  ; This now fails for both GAS and llvm.
>>      r0 =3D 1 + w3 ll  ; NOTE this does not fail with llvm, but it shoul=
d.
>
> Could you provide a reproducible case above for llvm? llvm does not
> support syntax like 'r0 =3D 1 + w3 ll'. For add, it only supports
> 'r1 +=3D r2' or 'r1 +=3D 100' syntax.

It is a 128-bit load with an expression.  In compiler explorer, clang:

  int
  foo ()
  {
    asm volatile ("r1 =3D 10 + w3 ll");
    return 0;
  }

I get:

  foo:                                    # @foo
          r1 =3D 10+w3 ll
          r0 =3D 0
          exit

i.e. `10 + w3' is interpreted as an expression with two operands: the
literal number 10 and a symbol (not a register) `w3'.

If the expression is `w3+10' instead, your parser recognizes the w3 as a
register name and errors out, as expected.

I suppose llvm allows to hook on the expression parser to handle
individual operands.  That's how we handled this in GAS.

>>
>>    We installed a patch in GAS for this.
>>    Jose E. Marchesi
>>    https://sourceware.org/pipermail/binutils/2023-November/130684.html
>>
>>
>> Pending Patches for bpf-next
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>
>>
>> - bpf: avoid VLAs in progs/test_xdp_dynptr.c
>>
>>    In the progs/test_xdp_dynptr.c there are a bunch of VLAs in the
>>    handle_ipv4 and handle_ipv6 functions:
>>
>>      const size_t tcphdr_sz =3D sizeof(struct tcphdr);
>>      const size_t udphdr_sz =3D sizeof(struct udphdr);
>>      const size_t ethhdr_sz =3D sizeof(struct ethhdr);
>>      const size_t iphdr_sz =3D sizeof(struct iphdr);
>>      const size_t ipv6hdr_sz =3D sizeof(struct ipv6hdr);
>>           [...]
>>           static __always_inline int handle_ipv6(struct xdp_md *xdp,
>> struct bpf_dynptr *xdp_ptr)
>>      {
>> 	__u8 eth_buffer[ethhdr_sz + ipv6hdr_sz + ethhdr_sz];
>> 	__u8 ip6h_buffer_tcp[ipv6hdr_sz + tcphdr_sz];
>> 	__u8 ip6h_buffer_udp[ipv6hdr_sz + udphdr_sz];
>>    	[...]
>>      }
>>           static __always_inline int handle_ipv6(struct xdp_md *xdp,
>> struct bpf_dynptr *xdp_ptr)
>>      {
>>    	__u8 eth_buffer[ethhdr_sz + ipv6hdr_sz + ethhdr_sz];
>> 	__u8 ip6h_buffer_tcp[ipv6hdr_sz + tcphdr_sz];
>> 	__u8 ip6h_buffer_udp[ipv6hdr_sz + udphdr_sz];
>> 	[...]
>>      }
>>
>>    In both GCC and clang we are not allowing dynamic stack allocation (w=
e
>>    used to support it in GCC using one register as an auxiliary stack
>>    pointer, but not any longer).
>>
>>    The above code builds with clang but not with GCC:
>>
>>      progs/test_xdp_dynptr.c:79:14: error: BPF does not support dynamic =
stack allocation
>>         79 |         __u8 eth_buffer[ethhdr_sz + iphdr_sz + ethhdr_sz];
>>            |              ^~~~~~~~~~
>>
>>    We are guessing that clang turns these arrays from VLAs into normal
>>    statically sized arrays because ethhdr_sz and friends are constant an=
d
>>    set to sizeof, which is always known at compile time.  This patch
>>    changes the selftest to use preprocessor constants instead of
>>    variables:
>>
>>      #define tcphdr_sz sizeof(struct tcphdr)
>>      #define udphdr_sz sizeof(struct udphdr)
>>      #define ethhdr_sz sizeof(struct ethhdr)
>>      #define iphdr_sz sizeof(struct iphdr)
>>      #define ipv6hdr_sz sizeof(struct ipv6hdr)
>
> Indeed, clang frontend (before generating IR) did some optimization
> and calculates the real array size and that is why dynamic stack
> allocation didn't happen. Since this is an optimizaiton, there is
> no guarantee that frontend is able to calculate the precise
> array size in all cases. See llvm patch https://reviews.llvm.org/D111897.
>
> So your above change looks good to me.

Thanks for confirming.

>
>>
>> - bpf_helpers.h: define bpf_tail_call_static when building with GCC
>>
>> - bpf: fix constraint in test_tcpbpf_kern.c
>>
>>    GCC emits a warning:
>>
>>      progs/test_tcpbpf_kern.c:60:9: error: =E2=80=98op=E2=80=99 is used =
uninitialized [-Werror=3Duninitialized]
>>
>>    when the uninitialized automatic `op' is used with a "+r" constraint
>>    in:
>>
>> 	asm volatile (
>> 		"%[op] =3D *(u32 *)(%[skops] +96)"
>> 		: [op] "+r"(op)
>> 		: [skops] "r"(skops)
>> 		:);
>>
>>    The constraint shall be "=3Dr" instead.
>
> We may miss an error case like above in llvm. Will double check.

Ok, thanks.

>>
>>
>> Open Questions
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> - BPF programs including libc headers.
>>
>>    BPF programs run on their own without an operating system or a C
>>    library.  Implementing C implies providing certain definitions and
>>    headers, such as stdint.h and stdarg.h.  For such targets, known as
>>    "bare metal targets", the compiler has to provide these definitions
>>    and headers in order to implement the language.
>>
>>    GCC provides the following C headers for BPF targets:
>>
>>      float.h
>>      gcov.h
>>      iso646.h
>>      limits.h
>>      stdalign.h
>>      stdarg.h
>>      stdatomic.h
>>      stdbool.h
>>      stdckdint.h
>>      stddef.h
>>      stdfix.h
>>      stdint.h
>>      stdnoreturn.h
>>      syslimits.h
>>      tgmath.h
>>      unwind.h
>>      varargs.h
>>
>>    However, we have found that there is at least one BPF kernel self tes=
t
>>    that include glibc headers that, indirectly, include glibc's own
>>    definitions of stdint.h and friends.  This leads to compile-time
>>    errors due to conflicting types.  We think that including headers fro=
m
>>    a glibc built for some host target is very questionable.  For example=
,
>>    in BPF a C `char' is defined to be signed.  But if a BPF program
>>    includes glibc headers in an android system, that code will assume an
>>    unsigned char instead.
>
> Currently clang side does not have compiler side bpf specific header so
> we do not have this issues. We do encourage users to use vmlinux.h, e.g.,
> for tracing programs, or for all kinds of programs using kfunc's
> where parameters likely being kernel structures. In the future, kfunc
> definitions are likely to be included in vmlinux.h itself.
> For selftests, we also slowly move to vmlinux.h.

We could change GCC in order to not install these headers, but then BPF
programs will need to get the missing standard C definitions from
somewhere else, be it vmlinux.h or some other source.  It will also make
testing the compiler much more difficult, as lots of the GCC testsuite
assume the avaiability of these standard headers.

