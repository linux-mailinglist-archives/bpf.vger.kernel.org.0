Return-Path: <bpf+bounces-5969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F6763983
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 16:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7001C21342
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F981DA3E;
	Wed, 26 Jul 2023 14:46:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC611DA20
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 14:46:25 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C100019BE;
	Wed, 26 Jul 2023 07:46:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q81rFh029454;
	Wed, 26 Jul 2023 14:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7HmK3f6Vpb7XSMCEjp4FzMK+nsR2AjkyPmC8tV9D5lo=;
 b=UmGa5YskZ7VjYhRDd0Lw7/UoNkzKoHK2dd1G/CLIRXJO+PqI0fhwMcfP0gKbf5m/0E+O
 5PIdEBpLq9t8f8mfZ4j8Wk6tZ7FDTtFmjifGazxWzrJ+PFUo4MJ5l0TXOATcesRK9LkI
 +617eFOOizTtjk95UVcN/DirLGJFPidmnl3zm6+nuX51qreYIX3u6JXCmbZV+zPYFHEQ
 2vOZfL9DRhOb0O16tvtY1ZtTgnIn3O/7+hcx4TvYj3J9yAdGnnUUiMQwYFmfHK327VCJ
 Ya9oBInbf6FndgHT7YxbCMIdUdmFq1x7FLwDl5DKvsoEje4nnjqTxXGzo1dWgYHEKmRI SA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1ynx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 14:46:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QDxgOW025392;
	Wed, 26 Jul 2023 14:46:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6t43v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 14:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMIngomnD4vK8q9f+GsWMA8Hp1NVkbtauIEzIm3PcmrcFgJPf6awShxIwr+ul9pjPzVUoCsDt5xvKqZsBWrHKeYOPenvRnEv/S7IWA5f9sSHqyrpC0hannfrloBHR+No1PMo9Y5YaJ+CG/A7KseC0yAPsFI7b/k2EtITabQVJXImycuyEGbDPXNs49DA2A7lcZLZXa42uD+2+l/dO7MaT64v2Q4Ixla2AJEPuwtLnIkrDU56YUE07S8+O+uAMsGDhZeFdCZNzeBPDdAy2BbVdWRnRTH2xwBc21y1VRAzPAdGpsegOI8/eDL/E6ulyIPHhLmJEJEXvML/lev9YO95FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HmK3f6Vpb7XSMCEjp4FzMK+nsR2AjkyPmC8tV9D5lo=;
 b=loGmUloXgdkTQoFHOzTkaSCwrAQlzfV6dGpFKeR1GD1YwpP0GGfLJXdDX6Jin9ZzwlDY+MsZPk50oVV/ajxDxMYkW5M6EG+49hHXBMfVfDuJD/2kB2w/tioD2lZ2Pvy0HkdRKwQEHds+/+GgND1SGgA58S037OvKuYDp/iUs/QMSgMSyOrc4yUxuGsfBN4kBR29jtLO4UkMu9ynJCeeCyQqP+umN3ifVASO5+hPQVBLR/0AKx+R9jj/oFfzowEdvD+RNJ0ZFd/lTMGQRqfKIjuy9WpEN79dRjgQIqXb2LeyuX4JJGU2iAJO7MLJGCKep8ETe06+YoAkkIRqk3m+Qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HmK3f6Vpb7XSMCEjp4FzMK+nsR2AjkyPmC8tV9D5lo=;
 b=t/GaN8NcYGaxLnBcx5UgYIjXCOdpnUkGcoSO4JlsBVbSBV2k2nRnIdDzUNbQOBGAkr3yWnLWxjmmQjKwQBiMRA5qdP1M0kw7nkISg4nlqe6hCmi2YQQq7H90amlvXBWJxFgOrAMUPye+ksbEGC9/6QQ/phbGH95CTf5eT1SNdck=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 14:46:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 14:46:09 +0000
Message-ID: <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
Date: Wed, 26 Jul 2023 15:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Yonghong Song <yhs@fb.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
 <ZMDvmLdZSLi2QqB+@krava> <20230726200716.609d8433a7292eead95e7330@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230726200716.609d8433a7292eead95e7330@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0509.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: b9374cb0-2bcb-4853-ee0b-08db8de70bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8Pq07jJroD1xkDTJXBh5/FBTQXdRi8rYWz1csZjsk0lnNKC9EkFkayOyLQrNE0IfvhTY0VZpo07W2psWtyqJhib0QyNQwlDVQeTPreiqJVr4Bw4DJ5ZQjOz3hX1Adg1xUqj8j2wWS59HKvjkaMSLq5EZiLWJNVbLS2GTDeO+wuR8VYTI2dSVD9dNls1c9LT9g8qOP77MRUCKwDhQgsL809+r8K0LGynHrMnxqDre8jme2SkkTeNkZqL8th09/RJo0mZBgZAzX6yFv2+EGI8NQYaX1rwHUgGWbAKoGEG+H+yoi3TKRKp4QHLl5dziNOGBgCVawMTaOAY+8sraQjcrZxTd1blaMImr0QgngpH1NmR8sxd5StLdYcWCJBNt/GFI8Hw+cIyAMVtoe8MLzXotEFl7/R7GE46+1IzBWxO/JTaKTmoQ4We0b0laNv08vY92Mw8KfUN4rV6bsriBbaemAZ0O8yVaThNcwZ82Md75GD3jxq5ZMX2jcjwHe5pq38wOmVtbdAFsyRsh8I7VQ4nwz3R4MN110zZVc2nMgHByxln+0HSIgMLVdQv1tpuHth2YhnduHIPmuNvVL7CK/IrPeJRXTP01wO83GXgr3VuwDsnJ2a+QUwkWIlEFOK3l9WuoGdFHlwndrUjjhcoB+a+nWA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(36756003)(31696002)(86362001)(2906002)(30864003)(44832011)(31686004)(83380400001)(186003)(53546011)(6506007)(2616005)(6512007)(6666004)(6486002)(38100700002)(478600001)(54906003)(110136005)(316002)(8936002)(66946007)(66556008)(66476007)(4326008)(45080400002)(41300700001)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZXZHbzZGdktFNzBVM0Y4anlQRmErd2NoT3JjMDMydW8vNmZINDRwK01HeHd6?=
 =?utf-8?B?aWMxY0RkTlZzU1l4bERxOVVRc2NxU2dWSDRIa21ybHkyemhwNCtiTTVZWW1v?=
 =?utf-8?B?K1JycUxURUUxYkRlWVU2bnpnZ296ck9JNlY4d09TUG85SEFuczNUSTBSaEFP?=
 =?utf-8?B?QjVQb3ZGWlpYVUJKSHVoVzB0TU5kYW5FQmNVOFFObUdrS1hhYmZOU2ZrN0Mx?=
 =?utf-8?B?ZXFkY0thOFZ6KzRjMjAwMUJTR0p6RStuc0F4NkhqZ3pzOEtMbEpkNFJ5MVU1?=
 =?utf-8?B?TkZicWg2WjJieSszZnFEY0lkUmxwRW5mOHA2VkVLZ1UveDFlMXRIU2lYRzVY?=
 =?utf-8?B?bTcrOWJCbXBpamVnc3FGbjhDc2JSNjZadkhIcnE5c3MreFUzUWZBV1dxQnlP?=
 =?utf-8?B?U0lEQyt6NTVoT0JaTHcwWUw5SHNVd3dQWGhkclBMRmlTS0x3UW96Zk8vditQ?=
 =?utf-8?B?QXpMdlFOWGF0dVhhckxXTlhaa29aaitoY05Nd2JvaHdWWHhGTFAzd1k3dVMw?=
 =?utf-8?B?Tk9BY05XN1lPRkpObUFCekZ6UXVFaDVXelZoTVJhVXFHK2R3OWNqSTZ1dERF?=
 =?utf-8?B?UEZpcTk5cHliMitsZnUwQ25EM2d4ZndzVitOTFJmTGtEMnlkYmRmZXBZa1Aw?=
 =?utf-8?B?c29UMk93VUNTT0srQjNmdlN5SzB2S2lLdml0NjVXR2MwZFE2WW10cHU5dVJH?=
 =?utf-8?B?Q3ZCOGluWUVjSjlWMmdDUWFhK1Z2U2NVMW9KazFGcUtUM25GRFJESGJYN2Fn?=
 =?utf-8?B?Q0hLUGFpZnI0azg3SGhRclp3eElkRzhvTVFHZlN4VnIyZ05MT3N1YkQ2ZXYx?=
 =?utf-8?B?bjdCczBtTElxeGZSdC8vdkgyM2lFL3hkRVBaTXl4SEhKZ1l0aEhEWGNTTXZz?=
 =?utf-8?B?K3FNVFFXK21nMnNEeFJ5YVNVUnQ0b0JTRVdFV29VUldpQ0h5TXJlMGRTajFi?=
 =?utf-8?B?MklyLzdhZHFUTkFCWXVqMHpUNmpjM0hQcFlNNk90K2JFQmNteHFhbFhvMTJE?=
 =?utf-8?B?L25hTmdZSW1XYUZVeHJGWlBYVGRaOFRlTjhwSTNlQ21jRWw1dmJmOWlDVUc4?=
 =?utf-8?B?blU4Z2puT0pMV2c1cHNRa1RIRm0rZldWTDNWY2lWSXptbFZ2Y2lXOXBGai9G?=
 =?utf-8?B?a1FSM21VYXl4U05qK1g5UDZMbldPb0lnWTVLbkZPM1pibzd6Y21Uc3RnMkNT?=
 =?utf-8?B?N0c4NU4vcHNTYzJoV0ZUZWlLS3VxdzZ3OVI1TFVuVDVLSkxJUmx3OXRpWEU5?=
 =?utf-8?B?cENLekZsQXpNeGd2MGJXSXRZVDdQdU1MSGh6Zy9GeEVLaGVWckZtYTFWaFc3?=
 =?utf-8?B?YjRxS3psMjNlaWZOWjd4SngyVmVGZ0gxNUJjT1hvMHFMNFYzQVdYODdmYUVC?=
 =?utf-8?B?OFBPVUtZdHFiUVpGZmlZM0RLWmRNVXp2OU1kQVhIL2d6NGNQTkNkSGJ0OWZR?=
 =?utf-8?B?WlhnMjBlMzEzcU9iRThtNzB0LzJGdldNdUY1a2hpMWlMWjdWZVhmUEoxcloy?=
 =?utf-8?B?VjIyZHVKd24wbHRYN1YzbDdjWS95ajdkeVVicllKNmlqYUVpN08wOUgzR1VR?=
 =?utf-8?B?eThKS1Q3eWl1bHZHQWZ6K043dHZmdUJYWVk3U3dtTXFRQ0o1T1RaN1FtN2dh?=
 =?utf-8?B?NzZIblRjcDc3VWhoMVdUMzF3bWF1anR0dEF4dkhHV3k2NjNlejlJR2dudFN2?=
 =?utf-8?B?U3BFWVBiY2k3bFhaOXBaeEw1aGt6cEc3dkh5NUYzUmlFNG43OTVTVjB4b1Iy?=
 =?utf-8?B?T1BqTlRGa1NhZ253bHIrM1lVeUZIQ2hSRDZWM1ZobVdqbzFabjh2aGk5WjMr?=
 =?utf-8?B?T0tQMlFvOVJrNnZkck5RcGMxQktmVzYzMEZocXZHaEs2TEs1ZnBYcTRXTXZY?=
 =?utf-8?B?SXpZelBqQitpSjZQTHhDRHdRaURXNVpObVNhdDE3aTFkdEV1TjZ4TEd2TlBN?=
 =?utf-8?B?dEZqVmthSkRhYmxYNnZmeTJEcXpZeDg0M3llSFZGaEpHTjZDc1MxRE9hdUdJ?=
 =?utf-8?B?L2puSkhOM05sUVlnVnEza3l1Wk5HTWJWRUFuQW82dEg3SzdTUWVUdFpuZ3BD?=
 =?utf-8?B?QlpFWmtOSFlLaDFlRzhveW55N0pHNklTdHI5Znpra243b1JOQVFoNWJuZ3hz?=
 =?utf-8?B?cFNGa3VtdXBycnNVZWNBVWFabGNQK25vN2VFV2k3a1BwSWd3c01CblFZRThn?=
 =?utf-8?Q?R8dMY16G7qTB8e9l2R1QaSQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ChUWZqDugT6xMcAtxnoqyp1qPndf6GVhoDkyPjn7ZORLhPopYm/6YdokyIhEPGmInP3AoNEh3IS5vmlfciQIcegnCB8wdQkPs9v7jHaFma2yjqifOXY4GuOVRKI+WrfJ2Y1LVnJyTaNzUGPUuWtbrawA+LBzrtjHRQWmQNV/ZCsiQtJUooYlRjrA9MCh4GC8GBIW88BZxGjjmYdFViRy4sS0u5sBg3jNbcACrSGY2wqztiTF54D0bm+2GgjyFKM0fPuZnY3wRd7rPl5CVUYSjjmLBFoIZtQ92nAcjqNQFGRWE7JK+3gQGksVb2hR1o1UDKtbK5npUrp/KCqiMEWPNg1/OkQKkCxmBVrbXXF8VBZs6h7zbCAWR697n7UwJNuDw8V7lbZdfTOMimUx7zt1TS7KexakG7TyYR0hbVssapGvj2l9WkkJCOH9Jadcxvz0jxtQADSKXYIGUqr5FRWsmZvSAZmX1GVLVKkPX37Qc8VLK5HXBaqO6DUXrNgLfep1IcdJ2JUOTz18ezjpYiYSObfl0ofHolyAyM7+iQZQKL2AMZHzEdPXVVh6aHjCnMdKMGELPXk2ND1g2veUbTGS5ouH9Njeo0eal5QkJhpNPVWPM/FyYfwM2T7Un0Ur/0UiMn5G0HOLjI5rjDuiNP3yN4ZSKT2U51ePWBQEzdXfIL+UqCacXVnMgGLd8133QM2Xp+wvQs/5Zw54nCNBjp2Kvm0rbYTQxEvrJ38EaZSpJ8hjkqheobwv5uGejKc9KtSyPmzgw6P6M9taTheuFOqhSlvWsqGUlwjMkpamE/S9gAVuVM1j6BfW5wNgvrvpG0QUE4YEcPAt1UPzrzelbebAhSilbFbWOaImpYlsb8mW/MPCaILp9vlGRp+ulenjPgb+26ncKZY/2jZ37yPdymnDUQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9374cb0-2bcb-4853-ee0b-08db8de70bee
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 14:46:09.0915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9c1zG8sGUldBWxJAK+Qx3vZbzBBjVb4pv2KZlX0xOPijT8Vqh0GZMgZ8SYbLzG5bIzYaqOFQJGDbBNPfw5cpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260131
X-Proofpoint-GUID: K5wYpiT3fv8rfKXAcG3bXVAmjUg9yxOW
X-Proofpoint-ORIG-GUID: K5wYpiT3fv8rfKXAcG3bXVAmjUg9yxOW
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/07/2023 12:07, Masami Hiramatsu (Google) wrote:
> Hi Jiri,
> 
> On Wed, 26 Jul 2023 12:04:08 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
>> On Wed, Jul 26, 2023 at 10:25:34AM +0900, Masami Hiramatsu wrote:
>>> Hello,
>>> (I resend this because kconfig was too big)
>>>
>>> I found that BTF is not generated for gcc-built kernel with that latest
>>> pahole (v1.25).
>>
>> hi,
>> I can't reproduce on my setup with your .config
>>
>> does 'bpftool btf dump file ./vmlinux' show any error?
>>
>> is there any error in the kernel build output?
> 
> Yes, here it is. I saw these 2 lines.
> 
> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!

This is strange, looks like some CUs were encoded incorrectly or we are
parsing incorrectly. The error originates in die__process() and happens
if the dwarf_tag() associated with the DIE isn't an expected unit; it's
not even a valid tag value (0) it looks like. I've not built with gcc 13
yet so it's possible that's the reason you're seeing this, I'll try to
reproduce it..

> 
>>
>>> When I'm using the distro origin pahole (v1.22) it works. (I also checked
>>> v1.23 and v1.24, both partially generated BTF)
>>>
>>> e.g.
>>>
>>> # echo 'f kfree $arg*' >> /sys/kernel/tracing/dynamic_events
>>> sh: write error: Invalid argument
>>>
>>> # cat /sys/kernel/tracing/error_log 
>>> [   21.595724] trace_fprobe: error: BTF is not available or not supported
>>>   Command: f kfree $arg*
>>>                    ^
>>> [   21.596032] trace_fprobe: error: Invalid $-valiable specified
>>>   Command: f kfree $arg*
>>>                    ^
>>>
>>> / # strings /sys/kernel/btf/vmlinux | grep kfree
>>
>> hm, if you have this file present, you have BTF in
> 
> Yes, it seems that the BTF itself is generated, but many entries seems
> dropped compared with pahole v1.22. So, if a given symbol has BTF, (e.g. 
> kfree_rcu_batch_init) it works.
>

Yep, BPF generation is more selective about what it emits in 1.25 to
avoid cases where a kernel function signature is ambiguous (multiple
functions of the same name with different signatures) or where it has
unexpected register use. You can observe this via pahole's --verbose
option (a lot of outut is emitted):

In a built kernel directory (where unstripped vmlinux is present):
$ PAHOLE_FLAGS=$(./scripts/pahole_flags)
$ PAHOLE=/usr/local/bin/pahole
$ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out

If you want to investigate why a function has been left out, look for
"skipping" verbose output like this:

skipping addition of 'access_error'(access_error) due to multiple
inconsistent function prototypes
skipping addition of
'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
due to unexpected register used for parameter

FWIW I see most of the below in my BTF output on bpf-next, though I am
missing a few, possibly due to differing config options since they don't
appear in kallsyms either. I don't see the DWARF tag label not handled
messages so it's possible that's a symptom of something

I suspect however some form of corruption in the DWARF representation
may be the reason a lot of these are missing. Would be worth trying
to "objdump -g vmlinux >vmlinux.dwarf" (file will be huge tho) I suspect.


>>
>>> kfree_on_online
>>> maybe_kfree_parameter
>>> trace_event_raw_rcu_invoke_kfree_bulk_callback
>>> trace_event_data_offsets_rcu_invoke_kfree_bulk_callback
>>> btf_trace_rcu_invoke_kfree_bulk_callback
>>> early_boot_kfree_rcu
>>> __bpf_trace_rcu_invoke_kfree_bulk_callback
>>> perf_trace_rcu_invoke_kfree_bulk_callback
>>> trace_event_raw_event_rcu_invoke_kfree_bulk_callback
>>> trace_raw_output_rcu_invoke_kfree_bulk_callback
>>> __probestub_rcu_invoke_kfree_bulk_callback
>>> __traceiter_rcu_invoke_kfree_bulk_callback
>>> kfree_rcu_cpu_work
>>> kfree_rcu_cpu
>>> kfree_rcu_batch_init
>>> kfree_rcu_scheduler_running
>>> kfree_rcu_shrink_scan
>>> kfree_rcu_shrink_count
>>> kfree_rcu_monitor
>>> kfree_rcu_work
>>>
>>>
>>> Here is the gcc version which I'm using.
>>>
>>> gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04.1)
>>
>> I tried with gcc (GCC) 13.1.1 20230614 (Red Hat 13.1.1-4)
>> and latest pahole (master branch)
> 
> Curiously, with Clang 16.0.0, it works (but many different errors are shown,
> see below *).
> So the combination of gcc/clang and pahole version can affect it.
> 
>>
>>>
>>> I also attached the kernel config file.
>>>
>>> What is the recommended combination of the tools?
>>> Should I use Clang to build the kernel for BTF?
>>
>> should work fine with both gcc and clang
> 
> And I guess it depends on compiler version, doesn't it?
> 
> Thank you,
> 
> 
> (*)
>   BTF     .btf.vmlinux.bin.o
> die__process_unit: DW_TAG_label (0xa) @ <0x4b138> not handled!
> die__process_unit: tag not supported 0xa (label)!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b241> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b263> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b290> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b2c0> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b2eb> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b317> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b33a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b35a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b37d> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b39e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b3c4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b3e7> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b40f> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b435> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b457> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b477> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b4a5> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b4d5> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b505> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b530> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b560> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b585> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b5b2> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b5d9> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b605> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b62e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b652> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b670> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b694> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b6b3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b6d9> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b705> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b72b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b753> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b77f> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b7b3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b7e4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b811> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b83c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b869> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b88c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b8bd> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b8e7> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b90b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b930> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b960> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b997> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4b9ce> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4ba00> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4ba24> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4ba4d> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4ba89> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4babc> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bae4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bb0b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bb2e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bb4e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bb6d> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bb8a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bba8> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bbc5> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bbe1> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bc01> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bc1c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bc38> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bc58> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bc79> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bc95> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4bcb2> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7efd6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7effe> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f11c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f143> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f178> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f1a4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f1ca> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f1fb> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f22f> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f25a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f28d> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x7f2b7> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eea81> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eea9d> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eeac3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eeaf3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eeb0f> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eeb30> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x1eeb59> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x340734> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6b4a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6b67> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6b8a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6ba5> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6bc4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6bea> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6c07> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6c2a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6c4e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6c79> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6c9b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6cc3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6ceb> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x4c6d15> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x30626ac> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x30626cd> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x3062814> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x3062833> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x3062b8b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f623f6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62416> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62437> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62458> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6280b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62b09> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62b37> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62c45> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62c60> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62d69> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f62e8d> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6305a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63ec2> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63edf> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63efc> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63f19> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63f36> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63f5b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63f80> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63fa5> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f63fca> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6fcae> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6fcc7> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6fed7> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6fef0> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f6fdcb> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70352> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7036f> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70394> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f703b1> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f703d6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f703f3> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70418> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70435> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7045a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7057b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f705a6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f705cf> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f705f8> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70621> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7064a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70673> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7069c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f706c5> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f706ee> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70716> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7073e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70767> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70790> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f707b9> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f707e2> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7080b> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70834> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70864> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70892> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f708c0> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f708ee> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7091c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f7094a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70978> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f709a6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f709d4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70a01> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70a2e> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70a5c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70a8a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70ab8> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70ae6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70b14> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70b42> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70b72> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70ba0> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70bce> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70bfc> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70c2a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70c58> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70c86> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70cb4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70ce2> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70d0f> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70d3c> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70d6a> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70d98> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70dc6> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70df4> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70e22> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70e50> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70e71> not handled!
> die__process_unit: DW_TAG_label (0xa) @ <0x5f70e94> not handled!
>   LD      .tmp_vmlinux.kallsyms1
> 
>>
>> jirka
>>
>>>
>>> Thank you,
>>>
>>> -- 
>>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>>
> 
> 

