Return-Path: <bpf+bounces-11024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D007B17DA
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19B1C281CF7
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C56347A9;
	Thu, 28 Sep 2023 09:51:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371F341BC
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 09:51:52 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D420126;
	Thu, 28 Sep 2023 02:51:51 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8qIrl032209;
	Thu, 28 Sep 2023 09:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g7ykvklAKlv0QsaFiaT+FaxteXPyGrC6JZdMa6mDWB0=;
 b=HJmFlEHntJ4VWJ7XDbLPTsFrm2q9bJzjYwE+poKoPSzESHyndSTg029Ls+xXYPvUgY1E
 U6SPIr22WuAJbQtOZStplrjFqWqgrs8SXGJkkYETzh0ZRDTAjsCBuyBDrKAuYcH/UQN9
 F3zVz+Qf8uEkmmIV8czo4DmTa2XI3sztSGzrrAkatYbRDaeGVHeFiTrnZfcJ+GER/k7w
 RKHiZ+2Mzv1o3HbkdfAl+K98POkm2enBIw/1JfP/5TnwBiI0iB+aLG60trmvNJjEdxHp
 yIjQ/936gUNcAnNGSKAsnJ8/bmsfmNsDyuaqYuAQITE84T5OB5sIwhBt1WxdlP1pR1nz fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2c0kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 09:51:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8sVom022459;
	Thu, 28 Sep 2023 09:51:02 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pffcba0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Sep 2023 09:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUqyKEZ3e5UzSUQBoQQ7VuytOyywkHa6p0Mz9C+2nlV6sAHXjTLrQMkf9JGD66AhzRaLayOO1RDDQUL/FJXTJEHy69RyJZNxhCgvRrP/46xXsHd+zmjXTN+z1dcXHaQ6IZxO18XSffWEk8S3gqSl9IQu2T0SurQHPbHK7oe+iDJFSaklc/0d1Gznotb8wEgqZ+tew017Oy6CDQKCc/vOAH+IoJbL7RXeBo5ik+ANM0iapUfnPRgJQUyn7paEnE9fC/fvraQAxTAVlot122a9TuvswgrYTC+ctLg9ix6gw8z/nZ1UScy5CYUhmZ/Nt3OmvhcZgYKLgqF8apGU8yYyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7ykvklAKlv0QsaFiaT+FaxteXPyGrC6JZdMa6mDWB0=;
 b=QuwTcuEuJsab5BieYjXoVi0wFZpyjzzhX9R8l8MV/qx2KecnunG4JL/BsLxQ5lCUV2jKAhamSDmRoOtV23SVTFK49Myq24MRJ0oI2Z24zWpuMA3ibAIsDX963I8nZS2nwlSTB7j07yBO/ocvuN44YwGR4ynoLsRzrr5trt36guzwWB4dnxWUxk1POyqyryW9+RKhvQIl+8fahsYvalRwBpWHQDj4+04svPJTMa5wOHLvgL86uLpsl9HM9XLMAIOMjumxme+M754RRrQvwqOvxYt8VPOYRWaQq4C8o2qOLfyzH/RhHUohvHtB2F7SS9d2N/PpoHOW2/g10erdDN4VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7ykvklAKlv0QsaFiaT+FaxteXPyGrC6JZdMa6mDWB0=;
 b=uaXhysE5bTrG71FyJhMcMjNH80htClMP3J2JQ5PcgRIwd+LZadBMsCCM7IOyUTKvIo4SyLZ1r0U+Ku1NuqGpJ7x8BWYcee94NnR0yRt/B1QBdKsokZ7gwbpb06OOjxdC/7EYkvq8B/e3WJNT9acl2ux4RvoFJVHRgDx0gy64p9w=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 09:50:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23%7]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 09:50:59 +0000
Message-ID: <e781d56c-c774-019a-8e5d-6263b26c54c6@oracle.com>
Date: Thu, 28 Sep 2023 10:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: The kernel fails to load the ko file because the btf information
 in the ko file is inconsistent.
To: Xin Liu <liuxin350@huawei.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yanan@huawei.com,
        wuchangye@huawei.com, xiesongyang@huawei.com, kongweibin2@huawei.com,
        tianmuyang@huawei.com
References: <20230922034736.970236-1-liuxin350@huawei.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230922034736.970236-1-liuxin350@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fea55c7-6f36-4a4a-eaac-08dbc0086b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Xn2c9+hNVk7vVYq6hDHyV3L1bPhd2F0+qWduKQ2YAap0SPEA23N9oCnYX4qT7oZIa0oF90peYacTM2WplUyJBd8r2tevPATfHdVSgq8GG2PT1kOm3orGHU/DQfIUC/0u7MwLPHWGxUPR5LofsJmgnrfC2m+Uww62QvWTu6qO6yE8KjOf6p6KtHqjVms3ISUXc9l9M+1/S9EYY5y/Klrm61z6NXzVuGFahRVn8Dg9RUrIHA7gvI2t15rj54E1+ELlUyZaYlg0qXbYVPJGmvgiRRq11p3b4lnyzrIsu35Zx7NPGQFNfvkWcB5KS8wdpsnJkJV22jznxl4+7R4q+Du1MeGI1y4Re0yeYM92exnjjDqzN/I2iGrSLfcZUE42WzDN4mlexkQYR50wdYLkiOPLJxsCR+eaeFAsVtPJFErdPw5au53vZIm+oxDa473M2HMGBoGAX7SQnJoK6Ed1D9awooW6TqOtyQBEqslbSkoQC/zyXXlEzS0zsMXYhyMXDSQZwn9eadNWovdrS8BUp1kzP4zqj5lxsAvujqPk4aCy0iGDLGxGW0MYN82w6FdT54lcA1mZhYaQpHuKQtKLkkT5WhsFCs1ur3g12zL3NW5eVL2GQ1zguMcbZ4gzc5GC/OQaexr7RInL3+syUnAU7jixuS/eQ3qnRZ3iynthKG4O/yk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6666004)(6486002)(478600001)(2616005)(966005)(83380400001)(36756003)(921005)(86362001)(31696002)(53546011)(5660300002)(38100700002)(6506007)(6512007)(8676002)(31686004)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(7416002)(4326008)(44832011)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0tvZ0pnSm9BNFVzKzljME8rQWNWRHlHUVZWcEVOUEF4blYrQjBMVklmdUtn?=
 =?utf-8?B?bTMwNFRaWUxOelNqa3pYeWUwQnBDWXp5ZFF0dGlualNHblVxbTlnOWJXZ0Yy?=
 =?utf-8?B?SC9sckU1ZFM2NDNqYmpjZ3NIcU1ENUV4cG1HeVdPUkdmbFJjT2ZKRUNpN0pl?=
 =?utf-8?B?MkpYVlZvWThTV1dKL0xzRWJVbmloNGxmdU1QdGhnbWNTNkJEcWJvU3EyMzgw?=
 =?utf-8?B?bnZNSHRLWkdqLzFkWCsvbnVnUGlnc0g1RjBNMVZacEY5UksvY3pLV3lZbjho?=
 =?utf-8?B?V3paTUNkTVZWbWNtRWRjR1Jvd2NsNEE0WTVrckxPUkV2WVpPS0J3cjZpbGg3?=
 =?utf-8?B?WlNjdU4zUTE3WTVrV3RCU0FiV09MZUpldmNhMitoMmlKV0pKVkxuNk1wOGpW?=
 =?utf-8?B?Y3hDWWNDQ0x0OHBoeFJsajcranZoOVVZT3dxTjNWbWFOVTVEZGR5RG9wYnp3?=
 =?utf-8?B?eW5KYWxqZUFVTjRPUktaak8vaTQweCtieU5QVVlXN3JZUkNxTUlEOUhwb2hm?=
 =?utf-8?B?c0JhYjk2SHRGbkNXdDY5SS9zUVVKWVNiSEVFZGxVYldoOWNLWFRuaEN1NWJx?=
 =?utf-8?B?Q0lydmFCRHBMSE01U1YrWWw4L291RXI5VFZSeERTMG5YdWlHdllCcm1MKzM5?=
 =?utf-8?B?WjRhTU5GZFQvbmhoYVRDOWlVcExNNVUxY1NlcGhhZVJGNURMdEF3WkdXSFB5?=
 =?utf-8?B?bnJQdGtKU1FvajIrVzR6QTZzT2Jmb2lSVjlNVWFIUEN5eFZ1K1lObC9aZ2V0?=
 =?utf-8?B?SWRlVzBKZkluNVdnQkdyM2ZTQUFwK0tTQkVMTjd3M2QzQXlRY3BsQXNCZlZt?=
 =?utf-8?B?Z1ZCaVBrMmw2QzNGUlowWEh5MWYrcVJCd1c1bUlZTGw5MHdmTGx6S1h4U1Ry?=
 =?utf-8?B?Um1sbzJTQ1pLL242NDZMcWhzWTZCZFVIZ0RBdW81dnc0NXVOTSttWnpyem1G?=
 =?utf-8?B?SmtLK2tMMkJZT0d0cWhuclRFY2Rwb3dLZFE1cThCR3lxVlNzTGdqaFBjM1dK?=
 =?utf-8?B?VkIyQWNBek5hUDI2U3pYUm15aDkxSENRNDNoNVR3VVBRRTJOYXdKQTZkSGdj?=
 =?utf-8?B?VFJmMnA5MFZ0aTNUaGtLWk4wRVI4VUlwaHA0dFVubjNyaWpaQVlFenVVTFJL?=
 =?utf-8?B?cXFVQUtSTktabDlDRUhDUkw0SExESWhxV0xic1dkUmhsWEQ0UU9wLzdnN21P?=
 =?utf-8?B?U083eVRFV0F0VkVTSWNsZ1dPQ1BSMlBQa2k0Z3ozano5RVkyNVY2R3VSd1VW?=
 =?utf-8?B?ckdjbzVkSGNKVGZ3b01kUm03VVc5b1ZNYWdSK1duSDdHRWlpSFlNRFJUdHZt?=
 =?utf-8?B?L0pSWG1MajBXZnBDbzBRdkZDdzdjMjMxSkpiWStBblVPUzN4QUtzbzVxR0pl?=
 =?utf-8?B?M0ZmMUVKaWRZYlhyZXM2Q3ZmRmJRR2drNjlyWmZxVU4wSGk0R1N1SjVXV0Rs?=
 =?utf-8?B?bzVOWmhZemZLUGZuTkd2ejZrK0lzU1FPM2EzWEFhaTEyTFJ5ZUYzSys3VnBK?=
 =?utf-8?B?dkRJUWIzejZKUDdCQWdPbDVXczdRS28vWmtsMWdvV2RVUWdqMVgraVp3bk9E?=
 =?utf-8?B?bHVZVUNOTVRLbGZMZGUvSkRGY3N3ZzcrVGFzU2FTT2cySHBYeDBnQUZwVUd3?=
 =?utf-8?B?U0NkUVJhNmFtVm02YkdyY0ZQWXIvQWZua3VMOVFIaGlYUXhxaEJKUG9WdE1M?=
 =?utf-8?B?WXh1eGtjYzg0TFR2VjM3cWwxMDZIZFdFL1o1QVZMNGovR3NYczV4cjNpd2hz?=
 =?utf-8?B?SUFoYkRmaGJGSkVpbTF0YVZsQ2lDSmhnYjRRTWxBN0IzQUlUeDBGb0lXNzJP?=
 =?utf-8?B?WksrMDNBK3dWUkE3WU5JQUlQLys0cjdhSGJ1NFZYQVg3RGN5ODRhWld2dGV5?=
 =?utf-8?B?cFQzQ0VHcWh2OFNaa0tJc2hxWmJ3OTB6OHQ2a211SnNoVUl5eVpHOTJJWEt6?=
 =?utf-8?B?d1k0T3g1eUhPUFlGVzR5cG5oZS9aQ2pSdUdJTGtKQXJYSHYrblVDTkNZNFFY?=
 =?utf-8?B?angxODZoUWE1SUphaFZkREhDd1MvZXlMMWhjV2U2OFNNQnUxMXNGVTlYakhO?=
 =?utf-8?B?TG1QRWJlZ0ROdThYb3B1TktQR3ROd0dmdGZYakU0RmVzQ2R2NjFwSzN6Y2No?=
 =?utf-8?B?cmdTZldlSzRzcjFtbWcrL2puNVFkZlExbHlORGlqZkk1VFdZemxscWNvVEpM?=
 =?utf-8?Q?WOqxeAEm7cCoHfmFq7PWHZE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aCtYUG0zUmxFbHY3a2RrZ1Y4QzVKS21nS1pWdUNLZ0crc2MvMlJKN1UzTEU2?=
 =?utf-8?B?Mm1XL3BlSUgwK1ZLbmFnWVpSZThnNHJSZjFGT1pIVTR2TUtPaFF3K2lMRmlP?=
 =?utf-8?B?aHNxRTNNTFFFRmNXUDZYSmtVcysxTUJGTE00NGRsRS9GOVA3bVJnMUlRTEZ1?=
 =?utf-8?B?c25XR3RtbFNaLzBlbjgrY2ZnVk5VV3M3UktDTWZpTFprTnpFdS82Unk3Kyto?=
 =?utf-8?B?eFFBbjlRenlRcFFTcEFCOFlaYXl3V0xpVFhWNXR5bUtadkdlTEZhREl3MGZJ?=
 =?utf-8?B?SEk5aHJuTGg3emlGa1hjem9Pek44Q2lHdnA4NnVIZmZLb2paK2c3UkEyUTd1?=
 =?utf-8?B?N01qTTlnOGRYcE1SajhoaFRxK0syZnEwRkdCd2N1RWFCOHpDd0VueG9BMGgx?=
 =?utf-8?B?cVJ1cHE0MFVOOFNMU2RwM2VvcGRNUEF5OVhTR3dHQjRaSGJZbHR4eG9zaElr?=
 =?utf-8?B?TlBXU1F3aEN6YXFNaS9GeWQxOGRZbFI2eUl5YURPdmJTbDMyL3VPMFhIdzlz?=
 =?utf-8?B?V1ZDQnBkM3FmcnNHWmJMaTg2bE1nVFZGR0V3UTVZVnpaWjJsOThPODRWRkpE?=
 =?utf-8?B?Y0xJOG9RMnRMWEtxWHE0alVjTVEraGFaT1QxVDRLWVNtT3lBM2I3OVpCNXZX?=
 =?utf-8?B?cGtoQkVrMzVMcDhwQ1N4OXdkMXdiS3NhN1Qrc0FmejdhbDc3VXN0K3AvT2FP?=
 =?utf-8?B?NmpuQzRzZ3VhMTBkRGIyM1dQZStRdmlVZVRjSWdvTjhMMzI2ZTBPaUU1TUdi?=
 =?utf-8?B?R21IMVRxTkFvWW5TWSszYlM2cy9NSXd5Z3BMejNtT2lqUXo2cUdCOTFLZk1T?=
 =?utf-8?B?K2IyL0pDVnVOVFQyMXhocDNQMjBOTHFGNUxQUGdNYjFDcnFYd1JQeFJVME5x?=
 =?utf-8?B?cVV3eEVuUjdIN1dEVnlxclRwZDJ4L2o0ZHFOZ2l1dnJ1eTJUblgvaFY2K2c5?=
 =?utf-8?B?VHoxQUhmQUlhejMzSnFjNWNJTENoNFpnU0VrbHRDWVpzSFFMN0wzMDhES0Rj?=
 =?utf-8?B?V2w4a3owMkpWOFZDeGMyekdRdVFMOEZjZzc1amJyb0NZVXhUZ0E4V1VlREgy?=
 =?utf-8?B?UUh1WDZTZS9Eby9QY3dobXRWZE4rVlRtYjhaYVBDajB0UG5nVG5hVVRzUldT?=
 =?utf-8?B?ell1dGhmZTBDZWN0anhpOE1UTFNuYWNqb29WR0tGNHpDaGVYQTNKc1k2QzA3?=
 =?utf-8?B?dnQyaWk1MVBSUjF1N2pmVEdiVnlLRG1SSDZUUjQvajRQWHFUS1FPSlpFTUJZ?=
 =?utf-8?B?TzcrNkIweWZsckxSSGlmUXM5WkhKcTY5L1NVaHUvdE5PKzBtQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fea55c7-6f36-4a4a-eaac-08dbc0086b42
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:50:59.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1CZlzonnjgr5U9p7O/PBe7GeIhQ/3mdhg38uj9JHw9PZDGcoRaaPTJp6Q3jcCccgWvqSYs3DDPYkuvlRzXy7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280084
X-Proofpoint-ORIG-GUID: AkvTkUZ-r2_kLkjM_1DBgm9ALavfUoFT
X-Proofpoint-GUID: AkvTkUZ-r2_kLkjM_1DBgm9ALavfUoFT
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/09/2023 04:47, Xin Liu wrote:
> Hi all:
> 
> We've had a confusing problem recently. The kfunc is used in the ko and
> kfunc is registered when the ko is loaded. Even if the code is not
> modified, the ko compiled at different times cannot register kfunc
> success on the kernel. It seems that the inconsistency of btf id causes
> this problem.
> 
> Is there any way we can solve this problem at the moment?
> 

When this issue has come up before, it has more been about having a
way to have module BTF that does not get invalidated by changes in
vmlinux BTF for tracing purposes - so for cases where perhaps the user
wants to build their module less frequently than the underlying kernel,
but still wants BTF info for tracing.

I'm not totally sure this will apply in the kfunc case you
describe. However what we've discussed is supporting standalone
BTF - where the BTF generated for a module does not rely on vmlinux
BTF as a base, so cannot be invalidated when the underlying vmlinux
BTF changes. The idea is that when such a module is loaded, the
BTF types are remapped however, so it _looks_ like normal split BTF -
it just so happens to be fully self-referential, and is not
de-duplicated relative to the underlying kernel. This remapping
has to be done at module load time, since the BTF ids for the
module will start at last_vmlinux_btf_id + 1. See [1]
for more details.

Would that scheme work in the kfunc case? One problem I see
is the .BTF_ids section would be out of date with respect
to the remapping of BTF ids described above; specifically,
if I understand the process correctly, resolve_btfids would have
constructed the .BTF_ids section with the old BTF ids (starting at
0). Since module load remaps these ids to not clash with vmlinux BTF
ids, the .BTF_ids section would be out of date. So we'd need to
figure out a way to keep these in sync to properly support
standalone BTF. That probably wouldn't be too hard (it's essentialy
just a matter of dynamically adding the last_vmlinux_btf_id to
the various values), but we'd need to think about the mechanics.
Something as simple as when registering a kfunc, checking if
it is a standalone module and adding the required offset to the
local BTF ids would perhaps be enough, but I'd need to dig a bit
more into the kfunc mechanics to be sure. Does that sound right?

Thanks!

Alan

[1]
https://lore.kernel.org/bpf/CAEf4BzYoG9RSMdEFZKp8JG+cXBxJEygd0tAtOn-hvjoFFDWfTA@mail.gmail.com/

