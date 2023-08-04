Return-Path: <bpf+bounces-7053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58463770BB0
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AAF1C216A3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDF223BE2;
	Fri,  4 Aug 2023 22:03:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE01AA8B
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 22:03:31 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED3E6E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 15:03:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCfpI007565;
	Fri, 4 Aug 2023 22:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=NlbEmITRAZmlI/c6B66kkFN5c6SjjodLF+kmWsbk0cg=;
 b=iTbv36tcKazc5g0vJiN251qVUyHKZPub3P9VyWO1Dfs4KDhLWeEp7ycy78+HQfyKGN8+
 A/X0G8NuvqKmDhp/wzbYgT8mcB9kSUyGUW6bCK2jAjkZWVnBLmsbf+ZRnl+pe0BS/PzA
 KtoVesoxgULCfMPqT+AJDOax0yHhaSdp9IfaflQ1SqhQyyz47oLU/bzXdSXR35u3+TSE
 +BYVxEuEaMP33HX8rSzKm/LKq8nwkKHwIT9hKXwqddgXxFT3mtjqE46PQWyF8F5O58Xy
 3vcPev1dNzg6zI5CTLsJI0xnFwH1IKaGBnDgNoJEeq4c5AiZds5P0HHhUAAhW3Wiy+/n dw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttdcvh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Aug 2023 22:03:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374Kt3kc034878;
	Fri, 4 Aug 2023 22:03:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m0a0fwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Aug 2023 22:03:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGwksID8p0uzRVpsMIK0+zmOtUarVxtV31xlYZrihy5ca2+egiAbEt3K2Fkcaorr9Zewuzmgc7ye706wY8HXXE+MEZqnZaiavZBy4WPj4uaIpCod0/cgJHN2II92vywdsmDB/pceTO/AbNBzRb05SDyshEdX+44IJX/sJvKoCX+I2HZgPOewYLvMfjYLcY3ESjGwC44NG58eP38OCRvnaJWA3EEeGTu4fKgbZ0bDok6fUsXorQGAkr2vkIKduno+z0MQJfRZsnClJSAiwabn0fqumyjWLlesV+4s95d7f0iUEWfCZ7Pe+XLCQ3XWw9C+ULqQ/w8n+SRlN1eQ/BWXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlbEmITRAZmlI/c6B66kkFN5c6SjjodLF+kmWsbk0cg=;
 b=E2vpx+SrN0uJloV16awiBUhskG4V7QIFVnI6H3zDhPOZqybC4IdUrYqQvPvsrmUn6YaOWJxcg2zJFwJvCRaGLebXYy0Y+YF3C9W11GKlJ5RkoR7gXjCGFaZjWdPAD/p+s/0RUtShUuEW+V1MlJsp3JMoHPSAhWCQNvFlVV1Q2zsfxGnBkwzqMeLb0NpdmUC8J53SeZ5qeIrsjF9lwv6mORUMuI1Fr15yDBp2c5O2y8VMUPk3Ck/qYs0aOMFU3NZM0Z0WjAypWaVPCn3axKZb77i7+gwNA1Zw2GPaK8kcmkVZdo1nb6ymzoRFfoRiuC6ky2U7euJWLnn+aBv2azmnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlbEmITRAZmlI/c6B66kkFN5c6SjjodLF+kmWsbk0cg=;
 b=bOH49lM0nBhsrstakEq2wx/NSKyKuOr1AstPDTpSNBYrMY42PEklkNlLK0gWg77AI9b0V7f+U1fUpMNAe9gdGsvrtxzotXnfFGU40d4kV8cWUAodEE0e0vT41YcgfUf6xIDyWiO1sXCsYyC2DxlGmImO3hHBUu64J+7aprM9QtI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 22:03:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.022; Fri, 4 Aug 2023
 22:03:08 +0000
Message-ID: <7eea26c2-e3c9-d212-1688-21d448649e07@oracle.com>
Date: Fri, 4 Aug 2023 23:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: FAILED: load BTF from vmlinux: Invalid argument
Content-Language: en-GB
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, martin.lau@linux.dev,
        bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>,
        =?UTF-8?Q?Tomasz_Pawe=c5=82_Gajc?= <tpgxyz@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, m.seyfarth@gmail.com,
        Fangrui Song <maskray@google.com>
References: <CAKwvOdm9PqNBLSZa_t5b=15cdtKvKq4q8WZr3i77W66m4FRAAQ@mail.gmail.com>
 <ZMwQivemlha+fU5i@kernel.org>
 <CAKwvOd=w3PFMDyZ1WL1DDx0Gyt-+sh7hYP_+8b9zEFu3uZpVXQ@mail.gmail.com>
 <afe71df3-48e4-837a-e85d-b6a6764eee62@oracle.com>
 <CAKwvOdn93Zpdkk3faNNdDw=tnMQ6Mxo5tTVCDmrqStU95MVQqA@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAKwvOdn93Zpdkk3faNNdDw=tnMQ6Mxo5tTVCDmrqStU95MVQqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA1PR10MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2b6003-ecc9-4e27-f8b0-08db9536964e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MHYnzVbrl2Ri7jstaRIACHWyt23gPVDtS2/xPLZoJkXYi1zSbhsZ9pZYCxLDo7DTVNgsfO1Py1GVBYqGf3ToBRnoC7lx8DUKfJ74bAHhUxd9J4uXO9UMilJVoEOjrB+CDGxzszJvnu+RB2h/xlmB0O3rJ64y/Pvjjgflx01Iuv4vc2aJtA62bT2Kqmko1uNuJK2iCVtZIFV1LmUq9xMxzCGL9J+lEk13ie2UkZunfzU3uESmgzp+coNR+lXkAQ2mqBwH+KbFEpVJuJFJ9GsVFr9PrOuXz/8l9IrwN0elkvUIxD+rkZacMOJQMKlNmII3WQ5YXBlYvxfa+tuv7UJ/a83EcVBv6HnDEHbbK/Q1Ui0dbE7S1LUTHYQvxsj2H8NFSzuTUvzraoupj8d/ZcLLVlB547CRsW6fKhLiEfQqRlZ/lOflsOerT3FuLWvHovMe64+2hvAnIls5eqOZMbBB7+qbJDWDQdHNP1DXAAIjQnEqiPckMA2fXi5GaKUA+VbMVrT3XiW3JpTaYA5NI7JfJe4Q6ksKa87N1a2mWUqAlq3ZMamVAXrtImKU9cgd/2lhVdIlwH1jaQ1OsWF4Kw8jRJmO76rKQjVmSS5KQVvBNrUCyNdGbN/HBfx6RdkAXECPp/TUJg7uESkqeY0p1a7BYLUQEm1RBnoUGTnqtB/UiVey6O65OS9b4vDfZPpfc8cQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(136003)(396003)(186006)(1800799003)(451199021)(36756003)(31696002)(16799955002)(86362001)(31686004)(478600001)(54906003)(38100700002)(8936002)(41300700001)(2616005)(53546011)(83380400001)(6506007)(6666004)(6512007)(44832011)(8676002)(966005)(6486002)(6916009)(2906002)(66476007)(4326008)(66556008)(316002)(66946007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHpqVWNOQVVhMjFnWkhzcUkxY2pTenRVK3NzcCtkNW1WVkZQZ0FFOFhRM1B4?=
 =?utf-8?B?Q25GUGtzeWpBOTh0aUFVRHhGNmpYOWorOG1qRUozcmFFTVdsVm5ETVhXZW51?=
 =?utf-8?B?dmZ4cXVlM2k5c2RMeFJWS2l0b1FDbGpkaTNwdFNnWEdtdFQ2dXVkaW9rMHdy?=
 =?utf-8?B?alZxalM5RXdIdkJwZDMzVGtXWFBPbW0ydktBSHgvVVl6bncySUhyR2VpWVM0?=
 =?utf-8?B?MXdzN0NUaDlKZXQ2ZEMrdmFPSG9GdllhenpHMzBoRWlaR3dBUmh2Z2ExbDdl?=
 =?utf-8?B?eWRKYzlIVDlTU0VaOGwwM1NwR1FPSFB5QzZZNmdvK1dTTDhHZTFLT0tPZk53?=
 =?utf-8?B?L3hCQjRtWEU0WUhucTFFVVhlTzEyOVVnU0tKRlZoNWppUjk4VU5pSnFpSjQx?=
 =?utf-8?B?Ui9rSUgvRXZiNXdKdG1MTXRxS2dsYkozTm5FTlliRE13SDF4UGRqMUFhRS9Q?=
 =?utf-8?B?dm1GZ3ZDRHF5KythOFNjUDg0RmU1cXVJSHhNWWsrZHFwb0xXN0R1MzZtUXhM?=
 =?utf-8?B?a2dKc2MyVE81Mys0MUhFWlc3ZFcwbCtGalJqR2NUVDdBY3JvUFZRVUE5Y1pl?=
 =?utf-8?B?OTlWbWY4OHVuaFhMVk0zbmNVS2ZUQS9tS2xETTIyWVpsWXlQT1pMNExMNlky?=
 =?utf-8?B?ODJXblVxZDl3azZ2Y2RYN1lnUTV5cWwxUFFqS2g0YllMdXB5TnFIN043RUx0?=
 =?utf-8?B?M05hSEkvT1VSS0w5N1ErWU1pTDQzZjE1SjRZYUxiTTcwaEV2R1ZiWGFraS9j?=
 =?utf-8?B?eS8zckIvMkJ1ODBscTZLakEzNHA1dmxvbkNMTTh1bGhlUUdabktud0V4aVZy?=
 =?utf-8?B?NzR6c3VvbGNpeDBPaWthNlRBd0RtckszQkJXQXdRYkNjVHh2cVZJQ2NiTkh4?=
 =?utf-8?B?QnNLeFcrWGduZWtmVnFIYUJHcVk0bmovcXdXRW1QT2NJSDlPcGxoTDgzbitX?=
 =?utf-8?B?alV4d3JJcEI0cHFLTXlYUFZPVDJMRlRwT3ZhUW5VVndzaTUzV2dKTHVUVVdJ?=
 =?utf-8?B?a0RkSE4wZDlvYkFzQjB6L2hmTU5TVG0vY2lCSFdHZlpyN2lzayswZGRmTFkr?=
 =?utf-8?B?bmV6NEtaM1UyRkZlVFo2R3FHNTkrbWtZUE9EUzdCejRPcEdmMnc3Rk1SMFAz?=
 =?utf-8?B?TlR1eDRlZFRvSnhrZVQwU3dkOUhwRjBJbW5MVWtzUGtabVFseEJLNnQ0Nkd5?=
 =?utf-8?B?UXNVUjdTZktuZlJrQVhTWGpQdnhDeUhoYnhmUjNkaVQ5RXE3NzF4OGFvSkdp?=
 =?utf-8?B?bkFqM3EzY2tKbkduUDFZTFJ4TDAxanVCZGlMY05UV0tleGQ1czdiQXRtSDBB?=
 =?utf-8?B?WFQ3V29XQUJjWC82V0U0Ny9QaWpoK0xsMy9TcWFLSk9qSDZkOFlmRE15U1Vi?=
 =?utf-8?B?MXJLY2UwbFhVNnRjaFdGSDFrVTF5M083ZFRZclA0TlMxVERlczFEajlGQVlN?=
 =?utf-8?B?TTlwMUNHbVdTem1YbmNiWEtkNWkvVTFORzAybEVqT29adGpKdmtwYTdQSHY5?=
 =?utf-8?B?YlN5NGVIR2hRWGMwc0EyYXhKVzRvR1Y3aHZ0SzBkWkg3cnhrZGRndnZ6d1k4?=
 =?utf-8?B?cmpJZlMxTDZYOGw4Z0pvaXk1RkFDNkg1M2RRUEhZd1duSnlPVmVCYzU2U08z?=
 =?utf-8?B?ai9xS04vTEJSSEtEWjcvWU5BVjZRSk84SjlPZHljc2ZvOStlb2dvQnE3Y09D?=
 =?utf-8?B?VlUvakJ3OThnRnM3NnF3U3lKQ0RQNmRhbDZUU0d1OXpxT281ZUFoNDF3VElC?=
 =?utf-8?B?WFQrMmdQQ3lJWDNRcVVrOTlYdGJTZDdlZTZ6OEJLdTV2U1NIOHoxbFZwbGFU?=
 =?utf-8?B?S0hORlhrUHpIczhMSElydzM5SXQ3T3U1bW1zbVp0eWgrWmRSK1ZLdnZLc0gz?=
 =?utf-8?B?cHBXdlhqTWQ3aHI0aVhjTVdvclNGb2QvWVlXMWJFLzg2WFJXbUpwS3BZOExT?=
 =?utf-8?B?R1dvbFVkb05SNUdBaVk0U3p6R09xRGMvMStWM0Z2Q1RBY1c4blpPdjlmN05Q?=
 =?utf-8?B?MGYvTlpYUHJaZlFnNVNOWDlpaW1CZWpIWjZyajVLWm9TU3YvclRvU0RmTDU4?=
 =?utf-8?B?MnFuOExKeDhqVEd3SmR4YkIvQmlEYXdyNXp3dDZ0bmFLM0dZUXBEcTU4dk5h?=
 =?utf-8?B?dnJWd3lieEhaRk96MVdEV2N6aGltdFRxMVRpeEFQeGZnM3YwM3A1ZkNodG12?=
 =?utf-8?Q?PzK7/PyOSFlxME1muCnr9aU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/MfB8Sra4hJyRj+psrXePIHfbPuAr4BEEZakmmRR61vAMTcF6zZHa2cUd70zGahpXxgnb2jUk/J3QH+WfqmQbmAbk5yia4wb7vW7yeBc520CbB0878a/6/lX1UcV6KyAHrDaYlf5Es8AtxoDbiYMIlvLNJJaiCh6eiK0BxqwSWe+t6Ry2emX+YEQZi5Hcoy9LrVmHbxFJKQ++5LOfC/5niOB2qqxz/pD4l/XFpEGiBxZ55x9J9S++oDLeXMDHRKu3bzGxn+JXM0SdKmSwvuj6GjxHS0lWREGAIYFr6QfR0xjanUCXfEKVJfQJDHaK+RO4LBjDL0HEkg0i+Txsn4Dg6YIAr7zy6AY6FqX50pXLkYMTKGrpJQmwnHjKKfe2VEPtyH7kCVmVH1fCbtAvK8mYYlWFFM2AIcV8/i9rSfMXx0tteN+ZWIRPoLKablpFRyfANgdkjKcgbZTfrH2v/fLdOU13gtZwQA81GeepImDMdEAv1LGHkZczyp4VcUSpMIQk4GH5toIs3/3K3DjZJr0OKDZDcUOhhOfK2X0lc0BqLeNbIQUQgAEedEJMrofDOGTeBIkIQU1ZlvKf/oNRDwvsrz4QUcLzkzHYwf5709daACKK94ahwhh+N90j/GiyikOAwg9ad3PgflIkjacGugZmPYfihgLkpBNDdIpRcvRwIY8dNgNqolyg7Mjb02ix4glNol6f7mj2FevtGuePUz0pKbmq17nlKoJVZkG7uxdEk/+iTKxsaM41cztRjCcppws4mAeosFYRXpbVphQbx1Qt1S7sFYbePApFagROgPlhZL9M8Pce+FxwSV5H4s2+Bfi0EAhXdaLh6DDDKKN4Rwf1VGXyNNXXLIXjkFiMZvbdJcAq7mIFNEjH9goXWm8ECI1KAXFA05MqmOPB7dqh9gw2IKnYAuTkYLgeuEst3Z6C9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2b6003-ecc9-4e27-f8b0-08db9536964e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 22:03:08.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ztK7gDlNjLKBSLcvCSS5q0rI0JiLr3krSLizCxTSEEz+e88ZpGbif08PqK4Oh5+/ct4uxIvdhLgSCkSZmvUlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040191
X-Proofpoint-GUID: k69LCeXckL2SpWboL2cxtRO8ZVYyOyJY
X-Proofpoint-ORIG-GUID: k69LCeXckL2SpWboL2cxtRO8ZVYyOyJY
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 17:11, Nick Desaulniers wrote:
> + Marcus (who also just reported seeing this
> https://github.com/ClangBuiltLinux/linux/issues/1825#issuecomment-1664671027
> and might be able to help reproduce).
> + Fangrui (because seeing dd used as a result of 90ceddcb4950 makes me shudder)
> 
> On Thu, Aug 3, 2023 at 3:10 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 03/08/2023 21:50, Nick Desaulniers wrote:
>>> On Thu, Aug 3, 2023 at 1:39 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>>>>
>>>> Em Thu, Aug 03, 2023 at 11:02:46AM -0700, Nick Desaulniers escreveu:
>>>>> Hi Martin (and BTF/BPF team),
>>>>> I've observed 2 user reports with the error from the subject of this email.
>>>>> https://github.com/ClangBuiltLinux/linux/issues/1825
>>>>> https://bbs.archlinux.org/viewtopic.php?id=284177
>>>>>
>>>>> Any chance you could take a look at these reports and help us figure
>>>>> out what's going wrong here?  Nathan and I haven't been able to
>>>>> reproduce, but this seems to be affecting OpenMandriva (and Tomasz).
>>>>>
>>>>> Sounds like perhaps llvm-objcopy vs gnu objcopy might be a relevant detail?
>>>>
>>>> Masami had a problem with new versions of compilers that was solved
>>>> with:
>>>>
>>>> ------------------------ 8< --------------------------------------------
>>>>> To check that please tweak:
>>>>>
>>>>> ⬢[acme@toolbox perf-tools-next]$ grep DWARF ../build/v6.2-rc5+/.config
>>>>> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
>>>>> # CONFIG_DEBUG_INFO_DWARF4 is not set
>>>>> # CONFIG_DEBUG_INFO_DWARF5 is not set
>>>>> ⬢[acme@toolbox perf-tools-next]$
>>>>>
>>>>> i.e. disable CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT and enable
>>>>> CONFIG_DEBUG_INFO_DWARF4.
>>>>
>>>> Hm, with CONFIG_DEBUG_INFO_DWARF4, no warning were shown.
>>>
>>> Downgrading from the now-6-year-old DWARFv5 to now-13-year-old DWARFv4
>>> is not what I'd consider a fix. Someday we can move to
>>> DWARFv5...someday...
>>>
>>> What you describe sounds like build success, but reduction in debug info.
>>>
>>> The reports I'm referring to seem to result in a build failure.
>>>
>>
>> This is a strange one. The error in question
>>
>> CC .vmlinux.export.o
>> UPD include/generated/utsversion.h
>> CC init/version-timestamp.o
>> LD .tmp_vmlinux.btf
>> BTF .btf.vmlinux.bin.o
>> libbpf: BTF header not found
>> pahole: .tmp_vmlinux.btf: Invalid argument
> 
> That's slightly different from Tomasz and Marcus' report (not sure if
> that's relevant):
> 
> FAILED: load BTF from vmlinux: Invalid argument
> 
> That seems to come from
> tools/bpf/resolve_btfids/main.c:529
> Which seems like some failed call to btf_parse().
> EINVAL is getting propagated up from btf_parse(), but that's not super
> descriptive...
> 
Okay, that makes more sense. Basically the stage where we read vmlinux
BTF to do BTF id resolution (BTFIDS) is finding an empty BTF section.

> The hard part is that I suspect OpenMandriva (Tomasz) and Marcus are
> both setting additional flags in their toolchains, which can make
> reproducing tricky.
>

I tried falling back to the config referenced in the earlier bug report

https://github.com/ClangBuiltLinux/linux/files/10050200/config_bpf.txt

...but still couldn't reproduce it with LLVM 17 + pahole v1.24. That
config did specify DWARF5; if we can reproduce this, it would probably
be good to vary between forcing DWARF4 and DWARF5 to see if that is a
contributing factor as Arnaldo suggested.

Alan

>>
>> ...occurs during BTF parsing when the raw size of the BTF is smaller
>> than the BTF header size, which should never happen unless BTF
>> is corrupted. Thing is, at that stage we shouldn't be parsing BTF,
>> we should be generating it from DWARF. The only time pahole parses BTF
>> is when it's creating split BTF for modules (it parses the base BTF), or
>> when it's reading existing BTF, neither of which it should be doing at
>> this stage.
>>
>> But I suspect the issue is in gen_btf() in scripts/link-vmlinux.sh.
>> Prior to running pahole, we call "vmlinux_link .tmp_vmlinux.btf".
>> If that went awry somehow and .tmp_vmlinux.btf wasn't created, it
> 
> Wouldn't we expect some kind of linker error though in that case?
> 
>> would explain the "Invalid argument" error:
>>
>> $ pahole -J nosuchfile
>> pahole: nosuchfile: Invalid argument
>>
>> I see some clang specifics in vmlinux_link(), so I think a good
>> first step would be to check if .tmp_vlinux.btf exists prior
>> to running pahole. The submitter mentioned swapping linkers seems to
>> help, so that seems a promising angle. If there's a kernel .config
>> available I can try and reproduce the failure too. Thanks!
>>
>> Alan
>>
>>>>
>>>>   LD      .tmp_vmlinux.btf
>>>>   BTF     .btf.vmlinux.bin.o
>>>>   LD      .tmp_vmlinux.kallsyms1
>>>>
>>>> And
>>>>
>>>> / # strings /sys/kernel/btf/vmlinux | wc -l
>>>> 89921
>>>> / # strings /sys/kernel/btf/vmlinux | grep -w kfree
>>>> kfree
>>>>
>>>> It seems the BTF is correctly generated. (with DWARF5, the number of symbols
>>>> are about 30000.)
>>>
>>>
>>>
> 
> 
> 

