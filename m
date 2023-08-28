Return-Path: <bpf+bounces-8869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437678BB68
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 01:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF651C2095C
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBF446AD;
	Mon, 28 Aug 2023 23:17:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626A111A
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 23:17:30 +0000 (UTC)
X-Greylist: delayed 6519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 16:17:28 PDT
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D32F10C
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:17:28 -0700 (PDT)
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SKRQgY031797;
	Mon, 28 Aug 2023 21:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 mime-version; s=campusrelays;
 bh=dqUs3XxpS8I1GNwdgCK2jTW21b39JwvpE+IjkvIQICw=;
 b=AsfBvntP0tTg2t+Hl0pIJpZ+yTCiziURvE/lQLsWg9VS05wAgMLR1g/HksqUtaar9WMh
 HAnswoxsMi2SUcyxQnw10K/922mYAfHjNhF7IRamlpuWPbroDZPsj/1Yf+a90r8r0oOk
 7kQHE3s+OgxFzZ8dk3gJpbNajDckxz+2sJeGKDUv5y9udU7drvo/pLqPbmFA/9W0Cezp
 ErCTwJ0h0kseeuz1p4q7BUHN8igfBhoAtDRH1nM3/qZBntOctendJunCwv/kNwOothOn
 /1toHhbmL1WBBIiuUBQjeKjMZK1+QcjZcuGwVIHk59e4cAnbLhOjnVGCV2uBvsMeOjsH sQ== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3ss2mu0ev5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Aug 2023 21:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arhgg0vDzn5zm1Wm4rZL71Av+3RfaUT9PotNeHHyXbuhtd4xiSDTdNCQ+Z0FY2xo1uDSQe2pAamNqp7r+NdBxDdmMQa2Rh63uu/3PNdYUKUYZy3ufHynWZsCAFM7Lh12yS9Kfrw5VVFn1rvNcUuIUQCYBHY3VLkSn1Hh/5zG/TeXriQa+Wxje8hIw8OzzkVMqmQI1KYVlVXnUiDkXoGLKW257Xt5d/bX2uyic1AiMBMp/cSzMbTrbR86Xm44EJlz7p3Q0JHtbuOtWpjl4u2fbrDJZVqMevWHUIM6aMOJE1DFyw9xU2+gj00vO8SwFXWsURNl8OKclNSrDmursy2NhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqUs3XxpS8I1GNwdgCK2jTW21b39JwvpE+IjkvIQICw=;
 b=Pvc35dNml8Po3imuHUEaLZLSAePM9VKur0wiGXsvaBeAVMWy9BbnxCFEEsoPqI8Ml/h+cJksNAsb1c/MefCRPDako1eRNcOChMHPM2AVnOc111xrYyrBqMyU4p6oNd8gCH8aPUtXY3IMb2UlS7+SdJxAKWRMyTxDD7Jm1cr7DWhdGIN58kvlBdj+CgSfpblD5Bh6gacWwGXEbAJhTVKOkzZ1GcqJIAQB0wv4tP+bLf+Cr8CfIf/sg9pxLvaVMk1s+nn3NpCNEbLBP/rVtR3V/qECBMGvIaYOFsYATbfSdK1sY1W/QmK3f7xHsGI4qWM0ex+1hcoAchprMS+bNJj46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from CH2PR11MB4454.namprd11.prod.outlook.com (2603:10b6:610:45::22)
 by SN7PR11MB7043.namprd11.prod.outlook.com (2603:10b6:806:29a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 21:28:25 +0000
Received: from CH2PR11MB4454.namprd11.prod.outlook.com
 ([fe80::ac74:e9c0:a0fd:13bd]) by CH2PR11MB4454.namprd11.prod.outlook.com
 ([fe80::ac74:e9c0:a0fd:13bd%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 21:28:25 +0000
Message-ID: <150bf7bb-5c2c-ddac-a85d-a15de77c3602@illinois.edu>
Date: Mon, 28 Aug 2023 16:28:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH bpf 3/3] samples/bpf: syscall_tp_user: Fix array
 out-of-bound access
To: Daniel Borkmann <daniel@iogearbox.net>,
        Jinghao Jia <jinghao@linux.ibm.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
References: <20230818164643.97782-1-jinghao@linux.ibm.com>
 <20230818164643.97782-4-jinghao@linux.ibm.com>
 <6eeaead1-ed88-eb60-a134-0777d9ac0851@iogearbox.net>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <6eeaead1-ed88-eb60-a134-0777d9ac0851@iogearbox.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZLNDHagMs8XzC6H4WyRQkRqH"
X-ClientProxiedBy: CH2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:52::33) To CH2PR11MB4454.namprd11.prod.outlook.com
 (2603:10b6:610:45::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR11MB4454:EE_|SN7PR11MB7043:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2401d2-7dbc-43f5-253a-08dba80db5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sId0IYWQIuxI+xS6+KCjShtzHDKMnEMD7Ys6T+MLQVYOowkVGKZGg0fKJSNThyQf9WZ7TgbID9qjhGBe4ZaRaYuA5BNXHXMAeTFm9WrvlbgeZ+hvXU4fejsSpQvIxAI2e+LivsYnZhoskrrU/FRdwCUrLteSlhsqefCEwF7IWOK/Gz7aRJP/Ej1QZfuDfXioZCWAxaHr2hdt06K3kBSDA1KzX9H2x9/JQSGL33csRYulxJvydjKWdvHmZvF71vY9vr66HWLqTTsKm4WcuXDQTWNaNhZy7KBI+ViKFbIvk/6gOGxAfajBI+n42+eRAEuSEN4KyS+CF/qy617EKeYtyD6+IrnUL1sRESDZZYnIta9j1VtqeELYf68PBrq4Fgd5o3ApKc2pV0VZCBp20Y2UobUPI+TSR1+H9ZXLq8sxywYBlMEPqnYa6s/IRQl5H9TDUEi99yBXyP3oNS1FAIBsM2gXJ2XtkFxB7oOAcjrLvubWpjkGCML8z3nkZVRrpBDdlq3H4v7IugAsJtVjjZWYz8/+3ZKAZPe9GW8D6YmSGYiP26XZ6eL8yq/GQXqKc+kT6Ocwoqo4pTcxbN3LKkXQEcLBssa507NtjOnlqc/rBQGvqwhcvl8ZzAI2PbRK/b82SgKmp555GnQDLLBURoQLIw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4454.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(186009)(451199024)(1800799009)(31686004)(6506007)(6486002)(6666004)(2616005)(31696002)(86362001)(36756003)(75432002)(38100700002)(83380400001)(21480400003)(2906002)(53546011)(33964004)(6512007)(66556008)(478600001)(235185007)(786003)(66946007)(110136005)(8936002)(8676002)(66476007)(4326008)(5660300002)(316002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWV2VGpyeGR0VUNwR0s2VVNMb1BGSWlMcVQxbjljSFV0SnJiNmNZdEs3QlFG?=
 =?utf-8?B?b0FyRmZSdHhVSElGT2dGNU9YVVUvSkxRTjVJdzZNY2ppd2lweHFsaDRLa1Nq?=
 =?utf-8?B?WVBNYmNjZ1ZrZ0ZrZ2dGZTBnaytwRUFncHgvV3piTno4T0lvTWRXb3RoMkhm?=
 =?utf-8?B?T2ZEblNBS2tYaU9pT3BEdHJDUEdSSFI5R052dFVJUk5tSmE4djVITk54ZEV1?=
 =?utf-8?B?ZFZKSlFKOUJWajRYWnFpdHMzTEN6MHE4b3BkOFFpbkpoaUJyUFlua0RRczM4?=
 =?utf-8?B?QWh4eE9uWk13d09nVS9YODEzUjdpZlF0by9YdUNoT004SUtJOGRSSXV0RnZV?=
 =?utf-8?B?WThIcVVjYno5eGFPOUlQN212NUdDMHQ3OW9hNDlIT29WRitOUWZPMmlYZ29V?=
 =?utf-8?B?a1h3RVYzYWsrSTltUWlzZzRtNGxUNUhPV01mZ3RYUFUweUJVMzloaUVlYmgr?=
 =?utf-8?B?UXZDQXZ4K3dpd2NCRGZoa3lRWkVnUVdLUjBPc0ZFbkNmWGVIZ24wZnN2TkJN?=
 =?utf-8?B?Kys2SFlEZUppNnRUSG1zc21Va0FVYTFDcERSYnVTOWxWLzhmMlJETTB6anBi?=
 =?utf-8?B?M2d3L0VsR3JDb29vcnlmSXdDdHdCNjB2R0NmZHVHR0JBVGdYc0Mya0h4SW9a?=
 =?utf-8?B?VzFYSjMyUjZuK2x2OWtkVktabmJsdUFBUGdtbWRWY2VyODA0a1JyejVGam5C?=
 =?utf-8?B?aXlwSW1sVEltYmZjQWFPTFJMbkZRMWZOb05VRmVuUVppblVJMUdiTHhoUGk0?=
 =?utf-8?B?akI4anBkTUZOcEc2UlBNMEdSL3JROExiV0J0ajRYY1ZVVUk2VmRDem5uM2JU?=
 =?utf-8?B?TEZuUG82YUlYZGcvWjg1V2dIUkFqdENmYVJYUGFOdG5TN1c2NUJqazRIcGYx?=
 =?utf-8?B?STJCaWpnclV1YVF4dm5aY2w4NzMrMFdDYmlHTUljVUpZazZkNDJBSHZ0QlRR?=
 =?utf-8?B?N1NSMXd1VUorWjI2RXJQWVREdlMzMUFGbjdCbTRNWEcwNCs4WWMrNTQrUm5K?=
 =?utf-8?B?QjlnL2tuWFN6UEJyWmhSbm1yaFVIYnBUdlVyTzNNL2pTWnUzbHZiTG40ZUlX?=
 =?utf-8?B?VG5qWXIwZlQyOGZFcXdaUm56VEZyTnRCbXF4WWF5eVk1cVN1clNzZGxRTzV4?=
 =?utf-8?B?VWxHcGR2OHFoTlR6aFRjZXlqMi9pTjJIQmNDTXlYcUEyekE3bTVKdUlkbFVx?=
 =?utf-8?B?NG1CNm5yYmRzOVZ1REpOTjk2TjlmY2poNVRSUElkWjdVdGttajErZ0FDaWtQ?=
 =?utf-8?B?WnhvZ3pFL1JZSmdFRWNUUHA0YWhRM1JHQ09Cdi80eVVkNEVuTjBRY1FtSGNh?=
 =?utf-8?B?bzZrVkRKamZCRmtieGNxVVJtVzdoaCtEbXFtVmdOYmt2b2FPUzlrK1FpSk5T?=
 =?utf-8?B?SCsxUmY3ZXFpblNndTNHK1pJQVJ6U29wTFVXZWVrSjRiYU5qZUhxMkl2RDhi?=
 =?utf-8?B?eW9rRFEzTVZNZkxnM2d4Y0pocTRRdGZyY1VJc2ZPWERFclplYmJBeVRMNVE4?=
 =?utf-8?B?T1M1a2dvQkhHREtzbTdBSUs1bjEwai9DdGZ0am5wRnBHME9DOXFvVVlteUxz?=
 =?utf-8?B?S2xOTDBlanlEVHg3Q09QWWJYNDhGWGFnQzU4aURhem5BWFBWNHVaUkJ2aUEz?=
 =?utf-8?B?L24yclVSaFBXUWxDQmVUWVZJNGNITGF3bWJWS1ZVa3BQbkhvUjlRdUdYMHdt?=
 =?utf-8?B?Q1JoNjlNdC9ISHlycmpQVlpWOFZGeU81K2dkRitteFRwbm03ZW15YnFab0JD?=
 =?utf-8?B?U3ZObXU5QUtsei9tS0hGN25DdnBOc3hrNTZ6QU9KcW51dlp5c250ZHlZNnVU?=
 =?utf-8?B?UkgzNWNGNE5adGxzVUdOd0EyY2Q5S1lVZ3daM0xOL1kxUGdHTkg2M09Mc3Vp?=
 =?utf-8?B?SUF3U3NyT1JQS0MzMUYyck1YeDRPckdSbnVEQTVwU3Vtbmg2SHNpeHdIREFR?=
 =?utf-8?B?OGE0Q1BRd3dyYlJjRjB3ZXZ1TDZsTXFOdVNKbE1DWTYvSkhXd1pIWERuUGZl?=
 =?utf-8?B?eWZlVU1SbDlKZk1MZWJiZHExVHNqUTl0cUlXZ3U2NUxzYWZJNmt4d05ZOTNp?=
 =?utf-8?B?QVowWXdTblVCM0F5RnJtM01FNFFEekRFS3VFOWxKM3l4b2NwSUNXWFlhbVY0?=
 =?utf-8?B?dWJLcE9qbDJNcXpCTm45UzJJLzFIZy9GT0lCcjIzclE3OERReVBhVjFwNkhs?=
 =?utf-8?Q?5ANNwxjM237Mh2MQwP8wI0wSFq/ZzHo8a9WYZ0Vqmjwq?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2401d2-7dbc-43f5-253a-08dba80db5c7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR11MB4454.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 21:28:24.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vv+hKLNb6r0eQCjQkShQZzekB4HG+p+Cpe9fYeBMT2CaUTI4pS3AqHaBQE+yy8ZwGzb08xDugPdDbv8OxPR4Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7043
X-Proofpoint-ORIG-GUID: qNYWwESfvt2qSOay6K59bf6jCfuDmx5_
X-Proofpoint-GUID: qNYWwESfvt2qSOay6K59bf6jCfuDmx5_
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280185
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--------------ZLNDHagMs8XzC6H4WyRQkRqH
Content-Type: multipart/mixed; boundary="------------7uhygfdG9rhMYVhAkdyq1f4N";
 protected-headers="v1"
From: Jinghao Jia <jinghao7@illinois.edu>
To: Daniel Borkmann <daniel@iogearbox.net>,
 Jinghao Jia <jinghao@linux.ibm.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Message-ID: <150bf7bb-5c2c-ddac-a85d-a15de77c3602@illinois.edu>
Subject: Re: [PATCH bpf 3/3] samples/bpf: syscall_tp_user: Fix array
 out-of-bound access
References: <20230818164643.97782-1-jinghao@linux.ibm.com>
 <20230818164643.97782-4-jinghao@linux.ibm.com>
 <6eeaead1-ed88-eb60-a134-0777d9ac0851@iogearbox.net>
In-Reply-To: <6eeaead1-ed88-eb60-a134-0777d9ac0851@iogearbox.net>

--------------7uhygfdG9rhMYVhAkdyq1f4N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

DQpPbiA4LzI1LzIzIDA5OjU3LCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6DQo+IE9uIDgvMTgv
MjMgNjo0NiBQTSwgSmluZ2hhbyBKaWEgd3JvdGU6DQo+PiBDb21taXQgMDY3NDRmMjQ2OTZl
ICgic2FtcGxlcy9icGY6IEFkZCBvcGVuYXQyKCkgZW50ZXIvZXhpdCB0cmFjZXBvaW50DQo+
PiB0byBzeXNjYWxsX3RwIHNhbXBsZSIpIGFkZGVkIHR3byBtb3JlIGVCUEYgcHJvZ3JhbXMg
dG8gc3VwcG9ydCB0aGUNCj4+IG9wZW5hdDIoKSBzeXNjYWxsLiBIb3dldmVyLCBpdCBkaWQg
bm90IGluY3JlYXNlIHRoZSBzaXplIG9mIHRoZSBhcnJheQ0KPj4gdGhhdCBob2xkcyB0aGUg
Y29ycmVzcG9uZGluZyBicGZfbGlua3MuIFRoaXMgbGVhZHMgdG8gYW4gb3V0LW9mLWJvdW5k
DQo+PiBhY2Nlc3Mgb24gdGhhdCBhcnJheSBpbiB0aGUgYnBmX29iamVjdF9fZm9yX2VhY2hf
cHJvZ3JhbSBsb29wIGFuZCBjb3VsZA0KPj4gY29ycnVwdCBvdGhlciB2YXJpYWJsZXMgb24g
dGhlIHN0YWNrLiBPbiBvdXIgdGVzdGluZyBRRU1VLCBpdCBjb3JydXB0cw0KPj4gdGhlIG1h
cDFfZmRzIGFycmF5IGFuZCBjYXVzZXMgdGhlIHNhbXBsZSB0byBmYWlsOg0KPj4NCj4+IMKg
wqAgIyAuL3N5c2NhbGxfdHANCj4+IMKgwqAgcHJvZyAjMDogbWFwIGlkcyA0IDUNCj4+IMKg
wqAgdmVyaWZ5IG1hcDo0IHZhbDogNQ0KPj4gwqDCoCBtYXBfbG9va3VwIGZhaWxlZDogQmFk
IGZpbGUgZGVzY3JpcHRvcg0KPj4NCj4+IER5bmFtaWNhbGx5IGFsbG9jYXRlIHRoZSBhcnJh
eSBiYXNlZCBvbiB0aGUgbnVtYmVyIG9mIHByb2dyYW1zIHJlcG9ydGVkDQo+PiBieSBsaWJi
cGYgdG8gcHJldmVudCBzaW1pbGFyIGluY29uc2lzdGVuY2llcyBpbiB0aGUgZnV0dXJlDQo+
Pg0KPj4gRml4ZXM6IDA2NzQ0ZjI0Njk2ZSAoInNhbXBsZXMvYnBmOiBBZGQgb3BlbmF0Migp
IGVudGVyL2V4aXQgdHJhY2Vwb2ludCB0byBzeXNjYWxsX3RwIHNhbXBsZSIpDQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBKaW5naGFvIEppYSA8amluZ2hhb0BsaW51eC5pYm0uY29tPg0KPj4gLS0t
DQo+PiDCoCBzYW1wbGVzL2JwZi9zeXNjYWxsX3RwX3VzZXIuYyB8IDIyICsrKysrKysrKysr
KysrKysrKystLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9zYW1wbGVzL2JwZi9zeXNjYWxs
X3RwX3VzZXIuYyBiL3NhbXBsZXMvYnBmL3N5c2NhbGxfdHBfdXNlci5jDQo+PiBpbmRleCAx
OGM5NGM3ZThhNDAuLjg4NTVkMmMxMjkwZCAxMDA2NDQNCj4+IC0tLSBhL3NhbXBsZXMvYnBm
L3N5c2NhbGxfdHBfdXNlci5jDQo+PiArKysgYi9zYW1wbGVzL2JwZi9zeXNjYWxsX3RwX3Vz
ZXIuYw0KPj4gQEAgLTQ4LDcgKzQ4LDcgQEAgc3RhdGljIHZvaWQgdmVyaWZ5X21hcChpbnQg
bWFwX2lkKQ0KPj4gwqAgc3RhdGljIGludCB0ZXN0KGNoYXIgKmZpbGVuYW1lLCBpbnQgbnJf
dGVzdHMpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIGludCBtYXAwX2Zkc1tucl90ZXN0c10s
IG1hcDFfZmRzW25yX3Rlc3RzXSwgZmQsIGksIGogPSAwOw0KPj4gLcKgwqDCoCBzdHJ1Y3Qg
YnBmX2xpbmsgKmxpbmtzW25yX3Rlc3RzICogNF07DQo+PiArwqDCoMKgIHN0cnVjdCBicGZf
bGluayAqKmxpbmtzID0gTlVMTDsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGJwZl9vYmplY3Qg
Km9ianNbbnJfdGVzdHNdOw0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX3Byb2dyYW0gKnBy
b2c7DQo+PiDCoCBAQCAtNjAsNiArNjAsMTcgQEAgc3RhdGljIGludCB0ZXN0KGNoYXIgKmZp
bGVuYW1lLCBpbnQgbnJfdGVzdHMpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBn
b3RvIGNsZWFudXA7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQ0KPj4gwqAgK8KgwqDCoMKg
wqDCoMKgIC8qIE9uZS10aW1lIGluaXRpYWxpemF0aW9uICovDQo+PiArwqDCoMKgwqDCoMKg
wqAgaWYgKCFsaW5rcykgew0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IG5yX3By
b2dzID0gMDsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJwZl9vYmplY3Rf
X2Zvcl9lYWNoX3Byb2dyYW0ocHJvZywgb2Jqc1tpXSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbnJfcHJvZ3MgKz0gMTsNCj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGxpbmtzID0gY2FsbG9jKG5yX3Byb2dzICogbnJfdGVzdHMsDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZW9mKHN0cnVj
dCBicGZfbGluayAqKSk7DQo+DQo+IE5VTEwgY2hlY2sgaXMgbWlzc2luZw0KDQpPaCwgYXBw
YXJlbnRseSBJIG1pc3NlZCB0aGF0LCB3aWxsIGZpeCBpbiB2Mi4NCg0KDQo+DQo+PiArwqDC
oMKgwqDCoMKgwqAgfQ0KPj4gKw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qIGxvYWQgQlBG
IHByb2dyYW0gKi8NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoYnBmX29iamVjdF9fbG9h
ZChvYmpzW2ldKSkgew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnByaW50Zihz
dGRlcnIsICJsb2FkaW5nIEJQRiBvYmplY3QgZmlsZSBmYWlsZWRcbiIpOw0KPj4gQEAgLTEw
Nyw4ICsxMTgsMTMgQEAgc3RhdGljIGludCB0ZXN0KGNoYXIgKmZpbGVuYW1lLCBpbnQgbnJf
dGVzdHMpDQo+PiDCoMKgwqDCoMKgIH0NCj4+IMKgIMKgIGNsZWFudXA6DQo+PiAtwqDCoMKg
IGZvciAoai0tOyBqID49IDA7IGotLSkNCj4+IC3CoMKgwqDCoMKgwqDCoCBicGZfbGlua19f
ZGVzdHJveShsaW5rc1tqXSk7DQo+PiArwqDCoMKgIGlmIChsaW5rcykgew0KPj4gK8KgwqDC
oMKgwqDCoMKgIGZvciAoai0tOyBqID49IDA7IGotLSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGJwZl9saW5rX19kZXN0cm95KGxpbmtzW2pdKTsNCj4+ICsNCj4+ICvCoMKgwqDC
oMKgwqDCoCBmcmVlKGxpbmtzKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBsaW5rcyA9IE5VTEw7
DQo+DQo+IHdoeSBpcyB0aGlzIGV4cGxpY2l0IGxpbmtzID0gTlVMTCBuZWVkZWQ/DQoNClll
YWggSSBhZ3JlZSB0aGlzIGlzIHJlZHVuZGFudCwgc2luY2UgbGlua3MgaXMgbm90IHVzZWQg
bGF0ZXIuDQoNCg0KPg0KPj4gK8KgwqDCoCB9DQo+PiDCoCDCoMKgwqDCoMKgIGZvciAoaS0t
OyBpID49IDA7IGktLSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicGZfb2JqZWN0X19jbG9z
ZShvYmpzW2ldKTsNCj4+DQo+DQo+DQo+DQoNCkkgd29uZGVyIGlmIHRoZXJlIGFyZSBmdXJ0
aGVyIGNvbW1lbnRzIGJlZm9yZSBJIHJvbGwgb3V0IGEgdjI/DQoNCi0tSmluZ2hhbw0KDQo=


--------------7uhygfdG9rhMYVhAkdyq1f4N--

--------------ZLNDHagMs8XzC6H4WyRQkRqH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE2/ZzTtJDFIshN/BBL9huahcPNUYFAmTtEXYFAwAAAAAACgkQL9huahcPNUZX
qw//XE50FLqrpJhjPX90VUMck3TSd7it9p6Iqg3QEM2PZW+67zNUKpS2wIB6dj8qkbqjUz1oEfJA
ur+lssCBQmKNp3zYxPe4gcyY0UrLytyt0TrG3jQ3zLhtXnetK8IXpAhpcHo2ZiZL99zw6U1/kTB4
3vtmGrHwRiIsh5TKXuP99npahP666EMfwAAdp4L0sSIz3E7o0Te6Q2ZWzCBF/i9k3K6wGEKd6+W5
yqjgdPW+KWG6yGzHVMt5U/0MOTLwjzMFagnns02DWm5jsHvbh1aZIxsF/ylU0A+1KwXoSo/HmKou
2jqdLPu+qSopVDxgJBwjEiBDjUD9qd6NedrDTNe+eM4/RqJcOB9o9W8jMn/jNmmP7Idfw3a+NUMK
J9u2a6Ru50rJ5I1cI8uwo5V1JQN/QHt3/Kbwyayg28NvhBBQD8mdNzaXPlKgKxkb5bRjQL5UBWAm
CPP367xHvrBV5fRdTcBjIhk7nazWcv1l8Tp4Wy4nV9xPpye2reHUgMED+j2jiXIKeGQtXBL7XsW9
Uq1KoLHGmM9a5M7Cav929iBCGe9TGgAPElMknnpDudaOSPwwX8hpDuRsP3CnjAtWZcAUlNtvk2zS
np6pjiqZHUdViPWd0M+jyYIIWVbuh259hZqBTC8XJq2IUj+vxGFekMVVQzF+U74GcPC1uzjObw95
Opc=
=CW+l
-----END PGP SIGNATURE-----

--------------ZLNDHagMs8XzC6H4WyRQkRqH--

