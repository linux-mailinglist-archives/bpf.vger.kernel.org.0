Return-Path: <bpf+bounces-3878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEFA745D9D
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 15:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE2C1C20982
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3EF9DE;
	Mon,  3 Jul 2023 13:43:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD42F9C4
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 13:43:05 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A756FF
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 06:43:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DTT3u011690;
	Mon, 3 Jul 2023 13:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7J0fU6G1s3UqCucO9KSxNY5IWJPZN7UetKXAq3RnrYk=;
 b=OZXM+NvQT9rUP853IV2otO0NGCGgTuDhbQ+eIZeqrZggzOKAqOUskhkHLLHrSavcXb/o
 I1qTlG7I4ZRP9G24JcqMBEr+v/lSwfaIMd4drgWr/CI6ifpEsLff8mA4Rj2FdhB9Jj+I
 45TkmFSbjZA4gxp8DAFISTKm8Qt+rACEcrYm2jWZQK2N7vt+2qVJ+Vnlg0iNR8huoId9
 4JM2WqBK8XB1XxO3uu8HGNyiv2CIxrhWJ1HicO/n2H2Fk4IICHX5iEQMN4UFVx2GYiP4
 W6q5QD6meieHqEwSsgwxvkPBWpkNcdpWbcQZmIIStIhxYkJm2m4WgrSoY2HgN4kZKe6+ XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpuamgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jul 2023 13:42:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363DgEcx009032;
	Mon, 3 Jul 2023 13:42:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak93ftv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Jul 2023 13:42:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKovWQV+Xo8mNkZobygq1Dc2YUwad5yNBfpF+ROW5IQIqKbeBts8UFLoQ2SMTlD5hb1RzfqITNtdn6m2+JAIrobGmw4tasfVO52hy5WAmIy3SHRZxHVnUYfUgCLr3LcroAXDJT9WdciuqfXkgXTkhIxRvIeaIvg/l71pywcSDXndN2MdFtcdZ6rco6zQMGZKsIi89z+GTtMjzXndSy4ZTTb+6Xos4E+q32VxwKnorgN69O/9gk2jlnBSJ2a1zs72RzsyThCsfmCPCB3cmCOmNVRmCRSc/NBDVieEDjctUp9PUhKHpOuRx5Xc+asCu/ON6rDz3Ud+FLge5VmTMXGLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J0fU6G1s3UqCucO9KSxNY5IWJPZN7UetKXAq3RnrYk=;
 b=QUZlshKSR9kKlSBjykCamNh1pd7Gj2hb/ukm5W0jm3nipOSu49RZTTkrNaw/jr7FGeNLlD8rMznCBha7OJsk1Fr5bAFSdD8OsFsSOdFxf3XH9OIybINDgqCB/xSh/yJ/FpbG9trDoMH8QAvgoMpas81yQHY6BYt2GzN/5RJievjagNxBbgUkIs23kXNTo9Ia5laQ/BX4urhXYP/jdGyM5QtGsfgQOMNH0AIEbh3EcCmMb43x+hmWqTMQM/g4EyPOG36seeMd486eHk/eme9Ms7WyR/qlba9thgJij/oEqej8DovsFirnpbLkSNb1EHcbK7rZ1OCjfH8EAtxezVqvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J0fU6G1s3UqCucO9KSxNY5IWJPZN7UetKXAq3RnrYk=;
 b=cdVL9tdv8N2nTfle1oBmbRFQNpTAKndYNrQbGEa7cSDXDniq3SZu0y9pfGywS7il9WCPo/ukgK1uDTeLVHX4jMQav0vtM5+Txc9+w4jgAemveuFnS4Q1rcgljiq/fr78eK0/FN7FMv1Ppgdd0R52YIuk9nE3Mf+flqqZZQp2ZMU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:42:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:42:37 +0000
Message-ID: <b972e451-3a1f-4f29-b03a-68ce3ac765f1@oracle.com>
Date: Mon, 3 Jul 2023 14:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 1/9] btf: add kind layout encoding, crcs to
 UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-2-alan.maguire@oracle.com>
 <CAEf4BzapHdQb=gXq9xLRGfRFBC=3xcQ=OSdV1o=+5nvgDwT4HA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzapHdQb=gXq9xLRGfRFBC=3xcQ=OSdV1o=+5nvgDwT4HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 22535c4a-c1de-4ffd-1d14-08db7bcb5c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JtrrtYVPW1c/LVq0uJUnilwCdc+ilADhm2BtK5ba4cWS4aXKz0pBUTYp9KM+Ah/KJZuf2nrs7b8/JKyB0LmY6tgNw2YOVOlORc6Zs5LMCsxvwS2Sw+HFg0hujpN1Uz7DoqsZZ2fdho/ptSueijpJt+vjdt/pfc0vZWtUmvaGCo4OtM977YSUGwGURXYbNWDCmocYsIVfVoauJN2zJ3hwCvWHHLmAyjukaYBCNn/wmropNlAzr6GQNUV9OsQNdV43dmaG/kTtN9pNzTSmL7Y+I4Rv0RyXzo4L6xdJgHUvJm8dnf6MQTT6jLLj0VviVEtzbwXDvNZyp5GmnLhGysQ/47Qf/xxjh2iVJmPa1aw/JSOaT39KfXPr1HJPRIeGKnqXsmbfbkoq7URoSD3Sy2HOSMMzCzWcf1mxG+jp+lVpP0FdT0jftdC4UBXVSmrK3jGJPPlESrHju9og6gSzQYaaxAt9gSlZ3N19ikzCsHu6il/Z41Fg3BAMDizh7jTM1QVuPevVovm7zvJBq8srzeCjo27JIOFEBKJ/4cpDhl5QqOMoF6WJ5r3hMPsxt662yOteDuR6gsAjuPHe6Xg3c56dqirXuc12zcFwBullZB0QiT0VzGE4uSMaAFwrWLunUQcZfSuj5WmGs9bcEU8WWpzwX/biokSW+xYY/KQHwvRXk4usJgksrC/YK9ksVM4gFznq
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(31686004)(478600001)(6666004)(6512007)(966005)(6506007)(31696002)(86362001)(2616005)(186003)(38100700002)(6916009)(4326008)(66556008)(66946007)(66476007)(53546011)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(7416002)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEp4TXM2UCt0UVhJTWhOaVFTZmd4K0xvOHhMV1JpV3lZZHpZWmFqcjUwbWRT?=
 =?utf-8?B?VTRoUkp6c2pQN2QyaE00a1ZDRDZNVGR5azVndFVhbWl6ckhkckNzZFNkMm51?=
 =?utf-8?B?VXduUS9pc000bGZQS1djMENjMHVNK0F0S2tjVjJjTjFJRHFHUE14a0lIRDhj?=
 =?utf-8?B?ZFdacThNMVQwZ3IrOGllYzZEYTdFTU9vcVJKM0llbE0vTGNKdGw0UFBMNWxP?=
 =?utf-8?B?MDdGamcrQk9FNTNLMGw1cTN4MkV2K3k5M2dTL1YvejFqM0RkZENQRWdtb1dh?=
 =?utf-8?B?bWVodG9hNVJSUEoxN3RVNWpDNWt5UXlLQkFFV2NuMUxRWjFwK2VESDNCTGZN?=
 =?utf-8?B?b1JJaStwWVgzZ3BwdCtYOUdGYnJnNFhLZGV5aWRLTzArM0t5bDBmY1U0eGox?=
 =?utf-8?B?R2xvaTBicXpnNmpmd0sycFozd24wZW5QaVNFWW9IdWcrOENIdm11Y1lpREhh?=
 =?utf-8?B?emJZRTAyOE1DemlUa2FGcFI3U25zNWRxUzduRGR4VlRzdE50TmExUEV2WTUz?=
 =?utf-8?B?N3YxbUNmNlR5WTNIaXhQV3lhdDdvUDhhTnJ4VlpnazIyMlgvd3V6L0laakJW?=
 =?utf-8?B?NUIzWnh3elFENGhXK2dOOUJ3bTE4bHFENjhhT1g2dlpBa1pjd1l2N3J6ODRL?=
 =?utf-8?B?MW1VQTZrYjlwSDBkdWlMQjFrRXBTaVNoTnlRcTVvTmZsbXhHTjZRcTRpOFpD?=
 =?utf-8?B?ejJZTlQwUzRIL3dQWGR5MFNnbkRLT08ySmJvVFdDTzM4R3BtcGxralRGOFQ2?=
 =?utf-8?B?UWVka3d0dVVLeFlYcEVSZDlpVWxFUGdFNXAvRGZaNWtsSHNlMXRzVCtlallD?=
 =?utf-8?B?bFlsMWp2VE1FcSs5WERVSGZhSjNoTGNJdldzOGhCdkVPSlA0M2NpMzhjUlgz?=
 =?utf-8?B?S1RLc3ErbExDcWFQR1d6K3dONHBwamNUZ091NFNsNkRwMTdLeWs5QkhkbEdz?=
 =?utf-8?B?b2RIeU0ybHRLVndneVZKTU9ocmpXZW1uZ25sSXluL3BWUlBYTnVBQUZiZWFp?=
 =?utf-8?B?M3FSYmUwSlJtSmFxMW4wa2Z4QWhlN3dLZmxSaE43OGl2TlMvNEdIaHBnZ2d0?=
 =?utf-8?B?b1BWSFB5cWs5MTJIN250OWhySndJb1BZWEtnMUZtMmFrUWJ3c0lqSjdxNWxK?=
 =?utf-8?B?S2tKTGJ3WW1aQlBHalFaaXVFcWVwRzJ3MGh0NElLUW54VjN6YWFnSXRHMXhW?=
 =?utf-8?B?R1UvV3UzRWF5RjB5MlU5M04xdy9DMVQxZURmYWUrR2MvL2RCNnRyVUM1Zkhv?=
 =?utf-8?B?SEc1QnRmeCthOVNXKzRyRlo2RG1QWnV3YXNScHpvMkh1aittS1pmYXU4d0Jo?=
 =?utf-8?B?a2NuN0hoWDNUY283b21GcHpxMThBSWk5R1BLRkJEa3ZIaVVXeGgvZnJTSWZr?=
 =?utf-8?B?aTRHVkhmUkJmV0J3bkF2eDdhRWs2Rm12V0FkdU4vek9adk9zYUVCcWZENVVp?=
 =?utf-8?B?THB2NzdCUnNYelhURjJsUkVSQXQ2YVNWR1VpOTN0R0Ftb0NCSElPdmlTVVJM?=
 =?utf-8?B?MmVyZWx2ZTBid2pKdGsvUnhlT0JOajBaN3FNaDNhRnJyT3BYT05kZFVkcjVC?=
 =?utf-8?B?emxjNzNVN01YdnE5SXFRRGt5MFBnRWxFNmJVTXloQ0Y4UVkrQWxjRmt4V3FN?=
 =?utf-8?B?QUJJdmxhbVpUSFBNVWxlc3BqMkF1THZhQ0dBWXN2WHExNG84TlFEdVZQV2Jt?=
 =?utf-8?B?NnRucTRldDBiOEdUTzlwa1NCczJWR1ZWbjVEWk8zUGVBV2h3dUlBRzQ2aVdY?=
 =?utf-8?B?all4MUhUbjJMWDR6SURrcVZmemloaysvMk5Uc2VHVDZ4RkUrSXcvRUhkOFZO?=
 =?utf-8?B?MXJkVlNWRVpjUUxDd2tiSXhzVmVrcHpaZ2VrMDZtVmxVU1NRR2tzcWR4Qk11?=
 =?utf-8?B?cVdOSVZKMGs5VUZnbzJWWHFzSCtFWVcwMjZoV0NLU1hrekVHWW9lTTFlams1?=
 =?utf-8?B?eUtPeE9GLzdaNnBiL01GSlQyMUFudEtNS1ltOSt2RTZXYk5RVTJYU0s0N2NV?=
 =?utf-8?B?Wno0OGxMNW84S016Ym1BbVB0Q1hCaXUwYWVUVGt2eVRISnRYY3FZdlFQVkR5?=
 =?utf-8?B?dVlKZE5BdlZoRFNLU3JTTjV3cWtzUGovVFJDT3JPaUg4citSb05RN3NtSHJJ?=
 =?utf-8?B?am9wODdxcm4vR01pWitOZFFCU2JkTHowMDFMeEFSQkNJQitkdmtXWFIzZHhO?=
 =?utf-8?Q?H7pXMg0G+HGWLsYkImaaygk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?NkVhRGdsdGRDdE5tcktBb3R3bjNxQXJJeUEvTDU1QTVGeFRYRUs1NnRXRUtR?=
 =?utf-8?B?N3JzN1VjVXcrL1UxME5HaGpKZkpBbjBlVnVDSFZsV201WTc4WVQyOHNMR2hz?=
 =?utf-8?B?TDFrMmlLeFVGSndHLzArQnhzT0IxanZMZG9hMlJQVHg3NFlFblVGVXJwUk1J?=
 =?utf-8?B?NHJXNEJqS1l3Q0IvTlBZT1VxWDlQeW9FWFFBRS9USU5hZkFNY2crU0w4NjhE?=
 =?utf-8?B?MFFHUjNyTWhpWjlBUnk5TUZVNGpkbDkycFJ4bXYxTFNzNkQrNzFHaE9ZSXhs?=
 =?utf-8?B?K0UyZ3kvRTA0MkptcjZ6d1ZubGVwZUVUS1JtM01iZDgrUlU4cFFwWmdYWith?=
 =?utf-8?B?MWpHV0FNNy9zSVdLUnNBMzJIaWFxT3h3SVQrMXBnNlBpeFZXdEc3TVk1THg5?=
 =?utf-8?B?NU1YQ1haa0JUaStieGVHSk9xMythMGRlajBUbDhUL0pXbHo1bW13Q2M0RDFw?=
 =?utf-8?B?blo0ci93R0h0aHUxRkNKa2RQTTBweXh5TUluckE3UmozRDZOWU9hdWdla2NY?=
 =?utf-8?B?VnpDb0tPSGxTb2hWTCtUaDcyVnQya1djSk5RSTBYT08rUWFtUU9JOHFtcEhH?=
 =?utf-8?B?UjVoTm5zdWV3TXhrTFo0UE9QQ2RlZ1Z4N09jSkY1azRvaHNCbUd0dHlWNFZa?=
 =?utf-8?B?WksvbHR6QlFUcUxSNVJmcVN1MERhaXhWZFIyWkRVYjJPY0IzZzZER2FLV01G?=
 =?utf-8?B?enNaUzhHMXlwbEY1S2U0bjJjb3gySFMrVlN3NllnZStacUxhcnVKYnhXRTBk?=
 =?utf-8?B?ZE1UV3F3V1NoQjRhMk1CVkZqbzBPSFo0RW9pNngrbGQwcjZkdFdqTTROUDlv?=
 =?utf-8?B?NEV4b2RtWkphbVBtZHZaOXVFcG90V1l6NmhGQ0QzYklrV1hJb1lMRWk5aC9y?=
 =?utf-8?B?cTdTTnk3eDE1bXJBT2RvNDgrbnRvMzVKb0s0TFFGK0I2cStIYVVJZ2ozWGVn?=
 =?utf-8?B?TlZxcll0OFNSUnl3N0V0SlMxbU13OVVnUU9KSGF5N2p5TFBWZGU4blRwQS91?=
 =?utf-8?B?c1VGYnJVOHptWWU0S3BPWDZwckNuaE1aNG1tMVlrVEcyWWdYa0tuMzZFd08r?=
 =?utf-8?B?S094c2ZneEVoSUJGS0JzalJ0NXZVd25HaUNYVStlbVYrQlp5U2dST3FkTlBO?=
 =?utf-8?B?TlNiNUtwb2hpeU4xWWFZemJ3SVZYa3dvcEpCR1phbGkxUForRTBTNGdtRGFx?=
 =?utf-8?B?SUc2R1RlL0FDZjJCWXpQRWtTUVRVaVc2TlFtZGNMWDZyeFppMmpYMkVJMHdx?=
 =?utf-8?B?WEUzK0gwT001d2grdnVLYkg4WThVZ2pReW8wOGd6NllVd0o5Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22535c4a-c1de-4ffd-1d14-08db7bcb5c9d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:42:37.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REZfln9nhv6pxQyPNmIeR4Aw3ZdbP7TL5Ml/TlliUb3YnDTD9Wmbs99iKzpsRIX241KX2O6jOBCV+EBlghsXGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030123
X-Proofpoint-ORIG-GUID: cU_bpk6o0arB9LJ_8XroQM40Mv6MWN08
X-Proofpoint-GUID: cU_bpk6o0arB9LJ_8XroQM40Mv6MWN08
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/06/2023 23:02, Andrii Nakryiko wrote:
> On Fri, Jun 16, 2023 at 10:17 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> BTF kind layouts provide information to parse BTF kinds.
>> By separating parsing BTF from using all the information
>> it provides, we allow BTF to encode new features even if
>> they cannot be used.  This is helpful in particular for
>> cases where newer tools for BTF generation run on an
>> older kernel; BTF kinds may be present that the kernel
>> cannot yet use, but at least it can parse the BTF
>> provided.  Meanwhile userspace tools with newer libbpf
>> may be able to use the newer information.
>>
>> The intent is to support encoding of kind layouts
>> optionally so that tools like pahole can add this
>> information.  So for each kind we record
>>
>> - kind-related flags
>> - length of singular element following struct btf_type
>> - length of each of the btf_vlen() elements following
>>
>> In addition we make space in the BTF header for
>> CRC32s computed over the BTF along with a CRC for
>> the base BTF; this allows split BTF to identify
>> a mismatch explicitly.
>>
>> The ideas here were discussed at [1], [2]; hence
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
>> ---
>>  include/uapi/linux/btf.h       | 24 ++++++++++++++++++++++++
>>  tools/include/uapi/linux/btf.h | 24 ++++++++++++++++++++++++
>>  2 files changed, 48 insertions(+)
>>
>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>> index ec1798b6d3ff..cea9125ed953 100644
>> --- a/include/uapi/linux/btf.h
>> +++ b/include/uapi/linux/btf.h
>> @@ -8,6 +8,22 @@
>>  #define BTF_MAGIC      0xeB9F
>>  #define BTF_VERSION    1
>>
>> +/* is this information required? If so it cannot be sanitized safely. */
>> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
> 
> hm.. I thought we agreed to not have OPTIONAL flag last time, no? From
> kernel's perspective nothing is optional. From libbpf perspective
> everything should be optional, unless we get type_id reference to
> something that we don't recognize. So why the flag and extra code to
> handle it?
> 
> We can always add it later, if necessary.
>

I totally agree we need to reject any BTF that contains references
to unknown objects if these references are made via known ones;
so for example an enum64 in a struct (in the case we didn't know
about an enum64). However, it's possible a BTF kind could point
_at_ other BTF kinds but not be pointed _to_ by any known kinds;
in such a case wouldn't optional make sense even for the kernel
to say "ignore any kinds that we don't know about that aren't
participating in any known BTF relationships"? Default assumption
without the optional flag would be to reject such BTF.

>> +
>> +/* kind layout section consists of a struct btf_kind_layout for each known
>> + * kind at BTF encoding time.
>> + */
>> +struct btf_kind_layout {
>> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above */
>> +       __u8 info_sz;           /* size of singular element after btf_type */
>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>> +};
>> +
>> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
>> +#define BTF_FLAG_CRC_SET               (1 << 0)
>> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
>> +
>>  struct btf_header {
>>         __u16   magic;
>>         __u8    version;
>> @@ -19,8 +35,16 @@ struct btf_header {
>>         __u32   type_len;       /* length of type section       */
>>         __u32   str_off;        /* offset of string section     */
>>         __u32   str_len;        /* length of string section     */
>> +       __u32   kind_layout_off;/* offset of kind layout section */
>> +       __u32   kind_layout_len;/* length of kind layout section */
>> +
>> +       __u32   crc;            /* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
>> +       __u32   base_crc;       /* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */
>>  };
>>
>> +/* required minimum BTF header length */
>> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
> 
> offsetof(struct btf_header, kind_layout_off) ?
> 
> but actually why this needs to be a part of UAPI?
> 

no not really. I was trying to come up with a more elegant
way of differentiating between the old and new header formats
on the basis of size and eventually just gave up and added
a #define. It can absolutely be removed.

>> +
>>  /* Max # of type identifier */
>>  #define BTF_MAX_TYPE   0x000fffff
>>  /* Max offset into the string section */
>> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux/btf.h
>> index ec1798b6d3ff..cea9125ed953 100644
>> --- a/tools/include/uapi/linux/btf.h
>> +++ b/tools/include/uapi/linux/btf.h
>> @@ -8,6 +8,22 @@
>>  #define BTF_MAGIC      0xeB9F
>>  #define BTF_VERSION    1
>>
>> +/* is this information required? If so it cannot be sanitized safely. */
>> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
>> +
>> +/* kind layout section consists of a struct btf_kind_layout for each known
>> + * kind at BTF encoding time.
>> + */
>> +struct btf_kind_layout {
>> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above */
>> +       __u8 info_sz;           /* size of singular element after btf_type */
>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>> +};
>> +
>> +/* for CRCs for BTF, base BTF to be considered usable, flags must be set. */
>> +#define BTF_FLAG_CRC_SET               (1 << 0)
>> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
>> +
>>  struct btf_header {
>>         __u16   magic;
>>         __u8    version;
>> @@ -19,8 +35,16 @@ struct btf_header {
>>         __u32   type_len;       /* length of type section       */
>>         __u32   str_off;        /* offset of string section     */
>>         __u32   str_len;        /* length of string section     */
>> +       __u32   kind_layout_off;/* offset of kind layout section */
>> +       __u32   kind_layout_len;/* length of kind layout section */
>> +
>> +       __u32   crc;            /* crc of BTF; used if flags set BTF_FLAG_CRC_VALID */
> 
> why are we making crc optional? shouldn't we just say that crc is
> always filled out?
> 

The approach I took was to have libbpf/pahole be flexible about
specification of crcs and kind layout; neither, one of these or both
are supported. When neither are specified we'll still generate
a larger header, but it will be zeros for the new fields so parseable
by older libbpf/kernel. I think we probably need to make it optional
for a while to support new pahole on older kernels.


>> +       __u32   base_crc;       /* crc of base BTF; used if flags set BTF_FLAG_BASE_CRC_VALID */
> 
> here it would be nice if we could just rely on zero meaning not set,
> but I suspect not everyone will be happy about this, as technically
> crc 0 is a valid crc :(
>

Right, I think we're stuck with the flags unfortunately.
Thanks for the review (and apologies for the belated response!)

Alan

> 
>>  };
>>
>> +/* required minimum BTF header length */
>> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
>> +
>>  /* Max # of type identifier */
>>  #define BTF_MAX_TYPE   0x000fffff
>>  /* Max offset into the string section */
>> --
>> 2.39.3
>>

