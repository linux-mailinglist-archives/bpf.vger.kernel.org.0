Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5366F6B2820
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 16:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjCIPDL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 10:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjCIPCd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 10:02:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E89F2C15
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 06:59:13 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3297edCj016239;
        Thu, 9 Mar 2023 14:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=n8AWNrDdcsLjCYtea5nVKEkKOzUP+2ICFrsJlylHewM=;
 b=M3zL5uRLyeKtmndex7DF+qVFZAIXy+LPmjJA4udeex+IwpFARd8KOvN7IYx5rnX5kGj1
 RUnyQ8GZuwSMbIvXWgtQ5h6vpZfgVuuRqWzuJD7DFt1LnqlGbtoZJ4cObCO+ZtWR+6nK
 waa4bDm3CSTO878nw1STmR3BMWxcdbDwspqwVmlGID9QCDFLiu+WJnaYj0PJcNvAMZPs
 znFTED2Bsb6szK80+esvRTTitahpOIl64D9jhZfn+LIbul0OWdagkNTGV91zemFAzqkP
 +REDYzWawx5MczTSQRetsuIEg8SJrzKgt3x5Q73+RpttfpkQGKsvdFQ42CYpAWVuOjFL 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417cjvj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 14:58:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 329Djj9q026675;
        Thu, 9 Mar 2023 14:58:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g9vad6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Mar 2023 14:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVYE79/TJNQGl4jBT8ehQAI82Ej5pRrYJwRcw52fY+PN2V68CVxN9bcCywiud4mUrtzR9pNqUKlW7AcsWFiAef/U/umI8MXTw3+FRvlO7LLeWalj07IpnkZnFbDV4ML7bM85pMbMa9IphwoqSAzv4FfUUj0kccpaH+I8reLl1qQ18+lZR3Zbfhlwni8mfzYDzi0a8G0J3hhM1fed9eIOZ+ML10XMCwRSvtNmy2zVm7z5bzAeXXDbIKJsKkn6DzBQIOKnVtXsGsKYjmrCLfHrEOVAcUvbuVToWdylbGWEerPkotk/BqtEkBeXjZVx9wWjho46uB1Quun0akSO2g93XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8AWNrDdcsLjCYtea5nVKEkKOzUP+2ICFrsJlylHewM=;
 b=GPWWzs7uBj1R/f3/wmi7k/CsNQdLPkICnRaCfNBpr1lTuU8tDXDBWYDMIsRdAXjcqeyWrBuVgFqFN2xg68xWglMWVRXGysQMkIazQLdQg3P+q5dC70ikDZdWpKvS6oBCgete+WjlEhYi8dKAOXJl2bEZXmT4o4J3KB3K06TLfGBq4LEuoDEK8nbTEXoBSEDuAzunjMQyXd9Y1o37goKEoQXcPKZbAnDEZ6qWfLpYq36T9IdDnzjcbKEx0q3H9OSNZSLMN2u6OZo74ZcBo/L7lsm7Npn0Gf7x6MiFuJP7ZE1WAR2QxLSjZIZlLyn4gUTcMQtTfRw+b3r2wPLwoQHubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8AWNrDdcsLjCYtea5nVKEkKOzUP+2ICFrsJlylHewM=;
 b=OLXrnw4vwYuVN0ZoGAvwllSWM1bcQd+IsSLBN6ZS3DAqZk2oQD8oIrmJg7ijB4hW/GDV2/604xYxA/W/IvFvsaNXmOyd54cm4I3B6Yz3iGqZNID5RLOtAmgPFqkJvsz/0uddAA/cNFb253/TeU9npxonvef8pStRkJ1x9jDU00U=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 14:58:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 14:58:48 +0000
Subject: Re: [PATCH bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
 <ZAk8L17/EfR8siaz@kernel.org> <ZAmV8luLw+umNGqd@krava>
 <ZAmwzzrBfmp2GQzr@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <c7ad1445-a6f1-266b-82ab-6a20cdcc4b01@oracle.com>
Date:   Thu, 9 Mar 2023 14:58:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <ZAmwzzrBfmp2GQzr@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0687.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: a356d192-02da-46a4-8c74-08db20aec951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bTF+zXNrpAJT+cwNU4qDHKN7unbSaiUSJu2KaOIVEaiDHqxAe7n9aaoVjU5EQTdaSi5RuLrqkIoLHkarRPE7iKNNcWDcguAkgekDUBJqR14mwMLshgv/vvdn4fYb2Ct7TlnNYp8+lveljwHFYucOr0vqQVVKhtBEMXOehSFxuWHXV/Cf8EY5ca7d3ICgEKQzJw5tAhpo4dMZqEeDpsXtBUl71gjUCFqAah1cFXubuh9iL7BVOECuTk58PwnBKutJc2ZqW8apPbqcedFtMr8dIzzWuETssVDxl/5Y9FQJZHOCel1XgohlHB9RuvQbe2xzI3dg/h6t2c7fnqG77nk1yH6DUnbnbcFQUEGKbCOh1FZZreLamdqrlcLZw4jrpBtL9Gl5HS2u/BS0kCp71s/cSPMdMbjwba+oPPjJ12Zf7V0TlDnffAR15K8f3wrlK2/TxFK8+849bZZQC1x/fdq1sdvI82oBa9B0aa/7/SB5cQWiuTAPDPfIA6EsJcKVAXi8WUrV7gx4co6OKOnDg/+HOv+XJQmFL3EV3YnLbgRWlCbmts1mFd3o7lIv+E3x5dd2yJlOuRzGnMpn1I9YASwy64X4vR4yEUsnO1pm9xvHbcC1h/xZk9+6+qQ+1ZIi6qwjmjx2SWCVW0qfyos2E31a24Vtwnee4HGZjNwLs9RWhEp4Ripm5KW79risv7xe9YXbfOIQ7DejcH4NzURAeTPGh/d+Q0/uvOk7f5Bhuc1SxTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199018)(8936002)(36756003)(5660300002)(7416002)(6506007)(6512007)(53546011)(38100700002)(6666004)(186003)(2616005)(54906003)(86362001)(316002)(110136005)(31696002)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(6486002)(478600001)(31686004)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBsL2hKeXdFdGdZeEIzdnBINGowQ0FmSWQ5S1M2UEMwOEdnYkZCcERhbkdo?=
 =?utf-8?B?aHNLM054R3BEWTdnTjVXK2ErTE8vdXptMUMwREFJbWNxTkpvQ3RtOXBZdm9L?=
 =?utf-8?B?WHRFcUlEdG9wTUR5M3FLVlhBaVpDcnF4YTd6Qzc3V1p3S2NCa2hYemlSNkRB?=
 =?utf-8?B?QTM2d0oyWnIzSnJKTVpSck9EcFBCRmJGNlFadk9KQ3owNGI4TXpkY1Y0aE1G?=
 =?utf-8?B?NlpHTVN0MUFUVFN3NVQwcU5MeDIzb3dPSmVvSlZrd3ZNa3NrcCtOOG9HSGxX?=
 =?utf-8?B?cUVRVzZ4ZTJHN1NXRWNLc2xEM2JyUW5DNHdxRStUVXBHb0JnZ3NWUkxBazNv?=
 =?utf-8?B?bmJydk9GbTYzS21IbkNrMmxDVEJVS3NzSTlncm9paXR1M2x1aHFNb0JCTGsv?=
 =?utf-8?B?cmt1OGt3cmswOG9Kd21HUFdzblVNa1hlY2N2TGkzUXBzcUFKVXZRc05SWTlT?=
 =?utf-8?B?OWpDWmFJdmQrc3BieHpOVHllbmUwR29JeWlWUXRzY3NJVlc3SXY1QmFMbVk3?=
 =?utf-8?B?L0lweld4TDBSZHk5VzlFSDlyN09IcFFUTVNHaVc5Q1RwcG5CYWhKT1EzaG0y?=
 =?utf-8?B?QXoweGlHUHhDbWtFaS9WOENITGoyMHMrZVo1bU5JRkpwOVBHaXBQd0luSFE1?=
 =?utf-8?B?MVBTZTQ4VnZzMDBjYTcwSHdMdk9PL09zeklIZVVjZFYvNEhjbEFoZ0d0cXBz?=
 =?utf-8?B?TVd0c2JRMWNmOUNoempCWXhHK3Myb0RVT3docEtzOE9XbHJ1dG9VZFczZG5R?=
 =?utf-8?B?S3pXWEc0NE9BTWxWZjNkS3o0UXlIaFQyRHdXb1p5ZXA4OFhZUXZCL1hCaWpL?=
 =?utf-8?B?aFVaTUwvaExUSDJuTy9VYnYvMEZmNnFWdDlsSHJESFJudFJZTzcranluMlNV?=
 =?utf-8?B?SFlOMnNrZXh1Ym5ZUUc2Nkl2Q2FhTkJubXNyeWo2SkVJNjFxTDNPOTZEVjJG?=
 =?utf-8?B?QzlHeWpjb0FTSmZjQi9YUS9ZOW5scGgrYmJhaWJ3RUg5L3ZQSG0zUmR0V1dx?=
 =?utf-8?B?SzBjemlYVUZHT21Va2EyY1dyQXhLalFGWCtDTVd0eHZHRjdyNlVST0N2VnNW?=
 =?utf-8?B?UllhTzdxQ0tNcHJFZisrTG1yRUhkUEh4OTVSbGIrYVZNNUNPWnllSnU2RXlz?=
 =?utf-8?B?THZkTWV2R0VIT2p1VTNGZHhhUWV5eUVwb1hBcVFZTUNyWUV6YlVKbmJUb2pP?=
 =?utf-8?B?aHh6akVNSk1XQWUzeGFtYXVYY2E2eVZZU3lsT3I4YXZmUXI2V09QZEJHV0l3?=
 =?utf-8?B?VThmYjh4M091bFdHakJ0RFRZUS9haWwzazd4alVSdVloWWVPL1F1SWtuWHFx?=
 =?utf-8?B?QmhtbUJGeWY5UW4yOWJCRDRNek1YYVdTRHl4VVpqb21RZlhFSWxZRmJranI3?=
 =?utf-8?B?aFJRN0JoTkk5eUQyQi8rNUdHVzJVRU8vZjB1TXZjcG1yb2ZEbVYzMFMrMnN4?=
 =?utf-8?B?Ym5qSHVobTZ6anpwd3hyMzFaV0tEWDZaM1ZlVnFhUHZLWlhOY2NpMjRyc3VG?=
 =?utf-8?B?WWJFZjZMWVh6UUpGOHFuOFpPWHc2SEpER2NlR1NHQW1MaDFLNkdzVWdydldB?=
 =?utf-8?B?bFViNE9MT3B0MG8yTUk3blRUbTZBUTBSaTd4TUxCUENWV3VtOHJnRGZhK3or?=
 =?utf-8?B?Z21vYU10WWF5MEMzZ3RGM2tXdWYrdEZtZzFNUHFCbHRENi9GVmhrZGRycDlY?=
 =?utf-8?B?NlFreWFLVjJHNVlZTWxQK2Jld2l3OUNVVjZ6VG1tZk1QSFp2aHdCYlhJeGF0?=
 =?utf-8?B?QnAvVHZ2Nm5pSnNzMTUySmVRNytxWDU0LzU0Q3dHR1dQdUI1cVBYbU5WYlhq?=
 =?utf-8?B?TVVzRUtRVUozcEVqUFZrR21YclpuQzJTNjg1LzV0K1RsODdWcjd1bldtU3JU?=
 =?utf-8?B?TEFSVG1aTUJqMXRqMmM5RXpQaUhqZjBpNjdPdGxpR3ZkL2ZxN3dNRGQyays5?=
 =?utf-8?B?UHR1Q2IxNWxpeWwzU0NaY2VVeGhkci85VkhXR2E4TFZLbVJOVzRaVW0ydXBo?=
 =?utf-8?B?VWpoQ2o3WXRkdytHSEp0OGtBWFFoOWFZYVROaXZycElMVkQzYjFVYkh5OVoy?=
 =?utf-8?B?NEVVRUdHSFlDMnVpM1R4b1NFbHlHTHN2ZUo5MWtwbHQrS3g3eTJTWmZ3RmZU?=
 =?utf-8?B?TXB3VUlFU1QrNFNSZlpJT1k2R0FmOG1RcmpIT1NxUFc4QU1uWjlRUzBRRVhF?=
 =?utf-8?Q?SuL4pi6wafoeTNGjXMqThtg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sGZ9pioIqjlACCGK1EZMmKvjNL1xGszjLZrEYdb3x0yw1QfTNSTdHgHex0dl3zuxMx6NmJt3ntk6oQKlwEwKlGCKkD10lGChqhCORMIpWFgEwGynbFsHRSfw3AnlUk2Jrsyo2qo49jMKnw6yb3yN3o9JmW42lmImN6MLQhPVZnDZkSXM8cU7dLfXvxcbKATohQ+kIoeYliLLWYp8gVD9rSahL51wnUNmDGOZ6/L2bFcpcyobXI7d9XirA/rheKBql/mQGLwbtNQmUwVfH1CN6DE862HQBThONLaT0+jPZuqQ+s68WrGkjfS7FcXCk1kPORHRheLVqayLOJhOuJAH8CJjlmfceSTyHEDJ1V6IHzR+iadL6+IG+6IEIIZ21SzgIDsjCFJMcJkcgROp1d78MZwKVKwXL6LQtQxxu0Bs1GI+0poAqSYPON0yaaEkj7KI/MWIpDfQXM2nMVL5XM6JwJblTMCe/nR5xg2v3rS0WS/xIDqPDRHDDXb57yR3YdtGVQM/m026QaRC6ejHg/FuHWfSNH2raRLjFbCcwo64Ub6C1JQfI4fbq2MY0MB259TfYhl1XizuEqpIcSIG4FXF1gtJz0rS88Hzed3IGhO8Ewjlcl8i72Y05PEz295HdU028NxXxZTMDNd7Jr7gvTlyazn7kXT9tiG53hkuboPO9oy2W9FoAegZzWiBeGm9nyfehJf6Coh5p+o5+ybNBP3zBYZsL0Xxq/dEO2M3o/fbjUKXd5/sqEZLClx01Q9dW7W+75V9AEz7LS1i2iyThBUYc9oIsH4MCPgARpJTm0wbhkJKwxFtDW/hWUM3PZlcUOxhxDSFcVs0v8oxe9rQZyTqs31QJUetyHIOYAao2e68t5/T1QwK1td1lMO2EAuht9yrfH/gcUetOKQsWM2Fb7FZPXWZ2oQNB2LbIyIb1Hfhg6Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a356d192-02da-46a4-8c74-08db20aec951
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 14:58:48.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc5MNRhrTrLPWC4K1F523pYyBSK7FBRHDJixdbFOCCmskCkhylRzYE7CzVbCeb/BHJb5m+ZAJ7uecUrTAOToPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_08,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090119
X-Proofpoint-GUID: qEPBZrg5iLgurKZ5Ed1BLL0wI4yqp2Xj
X-Proofpoint-ORIG-GUID: qEPBZrg5iLgurKZ5Ed1BLL0wI4yqp2Xj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/03/2023 10:11, Jiri Olsa wrote:
> On Thu, Mar 09, 2023 at 09:16:53AM +0100, Jiri Olsa wrote:
>> On Wed, Mar 08, 2023 at 10:53:51PM -0300, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Feb 13, 2023 at 10:09:21PM -0800, Alexei Starovoitov escreveu:
>>>> On Mon, Feb 13, 2023 at 7:12 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>>>> On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>> +++ b/scripts/pahole-flags.sh
>>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>>         # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>>         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>>  fi
>>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>>> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>>>>>> +fi
>>>>>
>>>>> We landed this too soon.
>>>>> #229     tracing_struct:FAIL
>>>>> is failing now.
>>>>> since bpf_testmod.ko is missing a bunch of functions though they're global.
>>>>>
>>>>> I've tried a bunch of different flags and attributes, but none of them
>>>>> helped.
>>>>> The only thing that works is:
>>>>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>>>> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>>>> index 46500636d8cd..5fd0f75d5d20 100644
>>>>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>>>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>>>> @@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
>>>>>         long b;
>>>>>  };
>>>>>
>>>>> +__attribute__((optimize("-O0")))
>>>>>  noinline int
>>>>>  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
>>>>> b, int c) {
>>>>>
>>>>> We cannot do:
>>>>> --- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
>>>>> +++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
>>>>> @@ -10,7 +10,7 @@ endif
>>>>>  MODULES = bpf_testmod.ko
>>>>>
>>>>>  obj-m += bpf_testmod.o
>>>>> -CFLAGS_bpf_testmod.o = -I$(src)
>>>>> +CFLAGS_bpf_testmod.o = -I$(src) -O0
>>>>>
>>>>> The build fails due to asm stuff.
>>>>>
>>>>> Maybe we should make scripts/pahole-flags.sh selective
>>>>> and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?
>>>>>
>>>>> Thoughts?
>>>>
>>>> It's even worse with clang compiled kernel:
>>>
>>> I tested what is now in the master branch with both gcc and clang, on
>>> fedora:37, Alan also tested it, Jiri, it would be great if you could
>>> check if reverting the revert works for you as well.
>>
>> ok, will check your master branch
> 
> looks good.. got no duplicates and passing bpf tests for both
> gcc and clang setups
>

thanks for re-testing! I just did the same for latest bpf-next
on x86_64/aarch64; all looks good.

Alan
