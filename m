Return-Path: <bpf+bounces-10013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D619F7A043C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 14:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA26281885
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 12:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C324200;
	Thu, 14 Sep 2023 12:46:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5F4241F9
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 12:46:35 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F91FCC;
	Thu, 14 Sep 2023 05:46:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E8mw2j030350;
	Thu, 14 Sep 2023 12:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CNzEXFXagHkee7T+8q1KhRTfKKCl0wVvwlJ9T2iE5Vs=;
 b=NffnsaK6jBxL/ADUzpYVo4t3pEkwN2pUoQ8YtSnQjxrt3leMPzcMS+qPbum1EryHke08
 RWGadtEJEmliuazJZlc5bnr6nLmexu+OhUNXo+E8rGX5iUTPOcRWdiZHzWyMqcXldxEW
 mAlBGQa8nkAiG1ggoVS2irD47Ok5ZHV6k87qGf4MAGL1ofWNkGDkhWQ2xYB3Uj3LUQoZ
 EXt1dlXM5Jc6W4D6h25I0qJkxrxOIl2AT7+DX/vIIEuPRpDu0QtWH5MFWh2TBZ/Xpqz1
 AzTa0cUtzRoHD/gu960wPNBZv2aXcK53vn6KdAsaKvA9C5Oh8W1X3MGzdciPOIoEbohE BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hdb1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 12:46:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EBSisG007417;
	Thu, 14 Sep 2023 12:46:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f59ctb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 12:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp6QMN6APo6lYraNUZSTA62wDJW4a5M7w8T8quOm9iRfVpH4EpBwtXR4F66sfQR/mtptN7gTSHviq3INNwkmVxrm2Ph3FYhhrR3Ye71kHQ6GJA7+Imec7PeoPp4FUpsio5GCz+334Im8spcnk3XWDh1k094UxnmSuWGYlUNZX6XKVnAOS8M7WS0nUXiL69rkp0lb6wnj2XjItY+OgmgI29tOTSFAo23ZcPYRSJjKEk+dy9+SvhrVZTmHveDo2eW93+MaBzMvU7IvyWSC9UNduGGkc4jGZwx1PRDiKVq4sMM8xyW9gKuufGPt/dfITXqvy+IffGOrcNCA2v/vU0zfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNzEXFXagHkee7T+8q1KhRTfKKCl0wVvwlJ9T2iE5Vs=;
 b=JUR4DYrzbMefk5XDgKcip3UUUqVB4jqOlDyYjZmCTUBjbGqZ7RTrtuHY7fspgtsKzMnjrrGOO8lXmaQMLO7QhIU9zkH7soPEvZWUzlKTzy5PuWAFMvuD93YWljYcnx25xtHvOBTkzuaOrPE3GNenePrp+EB/o4UU2eKvl9JTmFM9lMaPjJ1OVmR8eZKLRUOy4VTax2zIX3Dz91h0I4SPw3L5a4g1kWxxu1HU5Nx1ycdFfkExpJ1qVDcdYvOpoygs4qTxV3xl8oNHiCyc4WlCYvWCyE/ZfS5wk+SoI+r0eyW3DLwinH2uvdMTsT8HFeHAieowDEmroDB/qpQGGhgDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNzEXFXagHkee7T+8q1KhRTfKKCl0wVvwlJ9T2iE5Vs=;
 b=IN9cIYH8AwwAz/Zbn93iAQx0Kn4h8VMVh0rg4pizdzzQWqjn2v7tDT57tJeWQAL4Kr2JUQ8pDiEtQn3Tqfal6cDz1cVokt7khQcHgnzKu3/JaxnKrbf9+AavIYqfne7sXdOceZeybaQd4MmEtGgxzqdj4kAjXJooQ4qeRPzkQm4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB7811.namprd10.prod.outlook.com (2603:10b6:a03:56e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.41; Thu, 14 Sep
 2023 12:46:10 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23%6]) with mapi id 15.20.6792.021; Thu, 14 Sep 2023
 12:46:10 +0000
Message-ID: <6b77425c-7f09-ae6d-c981-7cb2b3b826bd@oracle.com>
Date: Thu, 14 Sep 2023 13:46:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
To: pengdonglin <pengdonglin@sangfor.com.cn>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
 <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
 <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
 <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
 <a0bd3ed9-afe7-49a4-a394-949bd5831d6d@sangfor.com.cn>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <a0bd3ed9-afe7-49a4-a394-949bd5831d6d@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0046.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe3655b-42fb-4698-e9b1-08dbb520927c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WSUGjFX+fma8MqjaqoHS/aB91ykf+7yJXnb53x+/J9Mzq+6aDqbGmkDJ4rpO8Ae+77Ah6KRzPpNZH1Nmko2neyzplJgXzF/+sP7eRQq93ROlf9giZ8HuLKKFz+rvSf9jGK1R6mlqu7Um8oVSN0eZgFK8aNJgRAvDB5dncj68yVa5s4VaZQbg91JMo7O8DndHL4Ou0Mx0zrHO80S1ZOdm/mIn0pRIt6vOSCEMny632SNVG1DxLYGwq/Tm6fE8ZzXRT6KFHL6FCDTnLGGRfItEiPrn6zUSuEIqKfjdb9ZAbQJtgmdua3qzisCHpLKCOyr/ZPinC8CycOPTEAfciFZ0Y7kZtWWIdHg6zKxd8t73eaq5f3Dp4U8fWPbX1a5Ds1MxaTW6zOrlYiwB9NNA3EkKl39+oiW+aBEBT5lLe2NBGUZ2bU4WV7VyLCIy9ylx+MiiDGupafwFlxzF6Wf80mtq84AZXlwJheLEp6R7Jz7wk1KttEzproXW4cevjfzs4euTXDpLJG3bCUEc+Sqwry6KeHcCZ1Ggt0J70DBGwnSQL/C7ZJ2VSqu1t48SboWUVbpVLwPQwRUAZe+ELRImbejfTDigsgt8dZeT7GVAXM5B/1Fan/KEFtkTZ+mKq1dDgSo3xvfIh3A/Hwzp3fZjYkdFMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(186009)(451199024)(1800799009)(966005)(5660300002)(316002)(478600001)(7416002)(4326008)(8936002)(30864003)(8676002)(6666004)(31686004)(38100700002)(44832011)(2906002)(6512007)(6506007)(6486002)(53546011)(36756003)(31696002)(110136005)(66476007)(66946007)(66556008)(2616005)(54906003)(41300700001)(86362001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDV5WmlKNTF1UjZhOVRmQ3V0WUpJbXpPcFZQL1JNbjFJRTVoR0VDK05aemZG?=
 =?utf-8?B?eEM4cGhIcmZta1dDc1VXdG9uM2h3V0ZOSWhCSzdMckYwZFptS09jUGZ4bXZD?=
 =?utf-8?B?Q2ZUTnZjdUtUbHVaV0hQWVYvSHZwZ0NVd1NVUGhuMlIxdldQVndUZjY1VTN3?=
 =?utf-8?B?Y2ROKzUyNkt5bncxdlFteUxrMnBpVkFSZTB3bWZ5T05hMExrc1JhaythcjVy?=
 =?utf-8?B?WGliYnlXTThrYU5oT3p0dlhYUnFiK3pXc0t4NkF3M1F2OEFFWExnQ2FXK2tO?=
 =?utf-8?B?cWxxMCtUN1BPZHBNTHBxcmxHSmp2WVZyNHMzVVQ0N1paVlZmN3JpcjB0NTNJ?=
 =?utf-8?B?NGE2L1pqd0NDVlZuNWVBSjFiVGJlWElMRmpMNXVheC9uMzVGWmlzYTBCWlM0?=
 =?utf-8?B?Yit5bWI5UFJYQVEyOVQ1UGpLSW9pNlQydFJUc25aa1Z4ZEtBVUEzQzYxYXZl?=
 =?utf-8?B?REtGTm9Ibm5oZEY5ckNvWUI2VmpWK2VpK1Vac2hUdWw5TGtocDJCVnlMMHdy?=
 =?utf-8?B?REIrUlNTU3FyZWhnWnRNMnExcjM2NEhrMG51eWV2aURDaTVtb2w1VHVtWlpL?=
 =?utf-8?B?UHRkV2dQcTBlYmk2NEF6ZDZsMkd2RVdzZWJjZ2JRRWtYR2V2aXZwVGJtVzBO?=
 =?utf-8?B?MXhVRGlONzJpbHVSN1JvYmwyNTYwbjVQNy9qSUhYM2dRZjZ2VXl2Qkh4Z0g1?=
 =?utf-8?B?YzZiZTkzVVdZdUlrWUhZZGFUYnk5UkxvczVnYzhNRnNwdzJqZCtzRVBodWlh?=
 =?utf-8?B?eE90VW1kZ1RSYWdWQ1h0WHhIMUlFZzhjZE9La0ZOMzA0eFFPcUhHTit6cEhv?=
 =?utf-8?B?bTl0UGZTQXN3YWZzanZqR1VWcVVjN3FjTnpDdWZJNElUM2Q2UHVUUG1idVJ5?=
 =?utf-8?B?Z3NFenZJK1pHMFFZOXhTSHAyTnJtTFg0M1Z3M084TDRFdUVPSUIyRlVKbGZp?=
 =?utf-8?B?Vk5XTmQwc29rbG5iTXR6QzZ4WFU4OUI2NG1nSkVnMHVhT1lRVUlBNGRZVFI4?=
 =?utf-8?B?SDNwMm9OTzNPckdZYTlJU0dPd0crWVhxRlBnMGpSVi9WYU9zK05OY2VNUGFu?=
 =?utf-8?B?cnRkancwNzBUY3o3aEJLZ2tsMVlnUTQxR2ZKM2xUTWF1b3RUTE1SKzhoaHYx?=
 =?utf-8?B?SXZTalExc1djeUNEcCtXdUFvblRXNkJnY29McGtyVG5UR0gxbzd3TXRCaE03?=
 =?utf-8?B?VCtqeEhTUzM1cXd1ajduTS9rNnVReStRc0lJMDBvWkFLSjZ6WFdKTCtpZk9P?=
 =?utf-8?B?N25CRjNYWW9zU1R0TGpNNC84UDFiV1pRSmdEeWw1OFZFc1UyRDJtSUZjN3g5?=
 =?utf-8?B?TXdWejhFWTQzRlF4U1o3S3c0NW1HNkpxZUZuNlFBWTR4dTdBYitHOG5XQTFJ?=
 =?utf-8?B?OG5EdzB6S2o1VEp3cVFQOTFOblV5WUQ1blk4cytLc1MrdTJpVzJWb1RjYXE2?=
 =?utf-8?B?dTNnMnRxTHc3L0Y2c3lOTmRnRDk3dy9scmpqUVA3MWVielM0czRNZ0YvYkc5?=
 =?utf-8?B?UFovdU9pckpuWmxrbUg5aHprUkpVTW16clRURHk1Nldjd1RmOEs5aWhJZlJX?=
 =?utf-8?B?NHlsZ2RzTjFWR2JFVURnNVdRaDhHK3lMZWs3OEFkbXErZjJMYXhZK29ubTJZ?=
 =?utf-8?B?Q0lLQjdKWC9RQW40WElqMCtvRDN3ei9rVnQxa2wwSUY4QmdaSWF2MFIrTlM3?=
 =?utf-8?B?TSt2c3hLTUl6SDVzdjAreFRjSmZnb3F2NEJiWEFYRStlU3BKVjM5NnBWQ3ow?=
 =?utf-8?B?R25Zb1Q0SEFUNTY0SXFOM05oN2RJUTNXY2R1ZHZsbmRsTERwREZjaWVxMGVF?=
 =?utf-8?B?bjUvU1Q1RjZxMCs3SEZrREE2VkFid1RHMVJieVVKV2psN2VsWE5CdzBIeVJM?=
 =?utf-8?B?a2ZvM3FROUtib3JRMlVpNiswWTFPV2N2S1g4MURtUFNiWk5HNk9hbUJKQUM0?=
 =?utf-8?B?MWxLeGdEbWlNMDlxNTIxakVkNDNERVlTYWpVWEIydituQ0xxbEtUQjk1QWFB?=
 =?utf-8?B?bEV0VTlhbmlhcm1aZTNIVVFFZUVDZHAvRjJvVHZlMzc5OW02cFdxMjFOUnVG?=
 =?utf-8?B?UkdRd1hvaFVZV3hUNGwxaGdIZUZJelpzOEQ1TTM4YUpKOW9qUE4ybXltTVNk?=
 =?utf-8?B?eG40c1N0N3VROEdPS0VyL2FTUDVyVEVYMHBtTWxnaTNlall2QWdDdlhzVkhC?=
 =?utf-8?Q?/y1HD6wtTgVp0T3v5CnL8PE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?NDFObkJLb2RIeFhDRmkwRXliZ2dvOEJEVEh0L1FkaGg3UkM4SjErb0NtU2pv?=
 =?utf-8?B?clB4bGFYSXR0dG9ZbEFrOVMxbmZyaE1DKzN6OW4zSytoMzlDTG1IMkhKU0hi?=
 =?utf-8?B?VkNuT3pzL2RyaVg4TC9LNWthMnFJMFF6WnZIZXdYQ1hySzRMV05PV1p6bVhX?=
 =?utf-8?B?SnVSSDVGTVl0MTJNSkwrMURVSytESWF6UTllYVN2VkcvKzd0TVZmb2ZOQ1RK?=
 =?utf-8?B?am1HZndNSGxLWlBadk93NFhMa213VVNyQnBFaFVpbFhXZWZRekVnUkdQY2F5?=
 =?utf-8?B?RDFsYU1xVVZzUloyOW5ORUt5dm9kOGdqMWdpMDJCWXZzSjBXSWRvTUgrSCtu?=
 =?utf-8?B?bkFDeUMzbnNkdmR2MnIycnduaUFIQ3FWbXR1RGFNSWN2aXRYZ21PblI1bWRM?=
 =?utf-8?B?UTc4YVJLVkFjS25SQ09FVERxUlkxV1dTS1R4Z3RrR2o4bi9vRFVWN2F3VThD?=
 =?utf-8?B?WHNhOXlOQ1J2cmRBaFRESXlRWjJGekR5RnJveHVYS0tValdESGN5Mmo3d3dW?=
 =?utf-8?B?RGdWWVd0Sk5VbkdINno5L3d0b2NvZm0zbzMwTkdNS0ZXd2J1dHljeUN2S29J?=
 =?utf-8?B?SlJBMlNMMFNnRWNoWG5WMDlxcXpQclg4SEZELzZYck5TS2hQZlZVZzQ2bElH?=
 =?utf-8?B?c0kwRytxVkFReWY5VU9sQUZ6YVhXbDhxQUxtMDJEc2lrM3J5R2V3TGVGcExV?=
 =?utf-8?B?Vk15ajBXT1hON25wV3gzK1h4bVlYRkExT0ZWUUZVb3FNUWhZVU1lelVvYnV2?=
 =?utf-8?B?MitUQlJQcHhocVdGOUN1eldEVzB4YXdYZ0ZCYnBZbTFGTkR2NHNNZUFmN3gv?=
 =?utf-8?B?aHVucDRKMy9KVk9FdlF2cjE0SndSK3hNd1ZRa1NKVngySDYwY0tzeXhpUzlm?=
 =?utf-8?B?elpqbStRZzRwamJTSUFQb0pJa3B6L3k2QUtwQW1mcHBoQjZVMDBXNXRRYjNu?=
 =?utf-8?B?ZUdlNnBKSEtXRHJFYmRIVmtoNHBzaUFWTE5xUlBQd3RPeG1YZFJwOElZZTVT?=
 =?utf-8?B?SndJa1lTNGZUSGdaeHpOcDVXOEM1UXMrc1dhNno3SFFGc2g5NkVLNURlMzJv?=
 =?utf-8?B?V1JWZlJzTURiUVM4d1FkeVA3SEZPYXUyYzFJdDM0S3ptYjdCTG5sRjJ5b0sy?=
 =?utf-8?B?MnJrTHhHZUUzeDdJSUx1VUJLdXVQUDFGTzBVWXpVZmk0clZzMkFldCtZU1Nq?=
 =?utf-8?B?WjJhNERXN09Xbnk4MHAzaTllR01uZWw3WEhDU0RVS0FaUVdDdU8wc3o2NHNp?=
 =?utf-8?Q?owejyA5R7bjwQ6D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe3655b-42fb-4698-e9b1-08dbb520927c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:46:10.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtrJYPLaMXGpE0K9nIDw/2IssMMTg7zl6YqKNVeU6DZb2LB7dApeHJ1l+6vdg+Vw3eDDxeLOcuVXN8U4WzAP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7811
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140109
X-Proofpoint-ORIG-GUID: 2Rf2RIY86H_-XTiPaioGjuhUf1zhPw47
X-Proofpoint-GUID: 2Rf2RIY86H_-XTiPaioGjuhUf1zhPw47

On 14/09/2023 11:13, pengdonglin wrote:
> On 2023/9/13 21:34, Alan Maguire wrote:
>> On 13/09/2023 11:32, pengdonglin wrote:
>>> On 2023/9/13 2:46, Alexei Starovoitov wrote:
>>>> On Tue, Sep 12, 2023 at 10:03 AM Eduard Zingerman <eddyz87@gmail.com>
>>>> wrote:
>>>>>
>>>>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
>>>>>> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman <eddyz87@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>>>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>>>>>>> Currently, we are only using the linear search method to find the
>>>>>>>>> type id
>>>>>>>>> by the name, which has a time complexity of O(n). This change
>>>>>>>>> involves
>>>>>>>>> sorting the names of btf types in ascending order and using
>>>>>>>>> binary search,
>>>>>>>>> which has a time complexity of O(log(n)). This idea was inspired
>>>>>>>>> by the
>>>>>>>>> following patch:
>>>>>>>>>
>>>>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
>>>>>>>>> kallsyms_lookup_name()").
>>>>>>>>>
>>>>>>>>> At present, this improvement is only for searching in vmlinux's
>>>>>>>>> and
>>>>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
>>>>>>>>> BTF_KIND_STRUCT.
>>>>>>>>>
>>>>>>>>> Another change is the search direction, where we search the BTF
>>>>>>>>> first and
>>>>>>>>> then its base, the type id of the first matched btf_type will be
>>>>>>>>> returned.
>>>>>>>>>
>>>>>>>>> Here is a time-consuming result that finding all the type ids of
>>>>>>>>> 67,819 kernel
>>>>>>>>> functions in vmlinux's BTF by their names:
>>>>>>>>>
>>>>>>>>> Before: 17000 ms
>>>>>>>>> After:     10 ms
>>>>>>>>>
>>>>>>>>> The average lookup performance has improved about 1700x at the
>>>>>>>>> above scenario.
>>>>>>>>>
>>>>>>>>> However, this change will consume more memory, for example,
>>>>>>>>> 67,819 kernel
>>>>>>>>> functions will allocate about 530KB memory.
>>>>>>>>
>>>>>>>> Hi Donglin,
>>>>>>>>
>>>>>>>> I think this is a good improvement. However, I wonder, why did you
>>>>>>>> choose to have a separate name map for each BTF kind?
>>>>>>>>
>>>>>>>> I did some analysis for my local testing kernel config and got
>>>>>>>> such numbers:
>>>>>>>> - total number of BTF objects: 97350
>>>>>>>> - number of FUNC and STRUCT objects: 51597
>>>>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC
>>>>>>>> objects: 56817
>>>>>>>>     (these are all kinds for which lookup by name might make sense)
>>>>>>>> - number of named objects: 54246
>>>>>>>> - number of name collisions:
>>>>>>>>     - unique names: 53985 counts
>>>>>>>>     - 2 objects with the same name: 129 counts
>>>>>>>>     - 3 objects with the same name: 3 counts
>>>>>>>>
>>>>>>>> So, it appears that having a single map for all named objects makes
>>>>>>>> sense and would also simplify the implementation, what do you
>>>>>>>> think?
>>>>>>>
>>>>>>> Some more numbers for my config:
>>>>>>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>>>>>>> - 43575 funcs, log2 43575 = 15.4
>>>>>>> Thus, having separate map for types vs functions might save ~1.7
>>>>>>> search iterations. Is this a significant slowdown in practice?
>>>>>>
>>>>>> What do you propose to do in case of duplicates ?
>>>>>> func and struct can have the same name, but they will have two
>>>>>> different
>>>>>> btf_ids. How do we store them ?
>>>>>> Also we might add global vars to BTF. Such request came up several
>>>>>> times.
>>>>>> So we need to make sure our search approach scales to
>>>>>> func, struct, vars. I don't recall whether we search any other kinds.
>>>>>> Separate arrays for different kinds seems ok.
>>>>>> It's a bit of code complexity, but it's not an increase in memory.
>>>>>
>>>>> Binary search gives, say, lowest index of a thing with name A, then
>>>>> increment index while name remains A looking for correct kind.
>>>>> Given the name conflicts info from above, 99% of times there would be
>>>>> no need to iterate and in very few cases there would a couple of
>>>>> iterations.
>>>>>
>>>>> Same logic would be necessary with current approach if different BTF
>>>>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
>>>>> cohorts are mainly a way to split the tree for faster lookups, but
>>>>> maybe that is not the main intent.
>>>>>
>>>>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
>>>>>> extra memory. That's quite a bit. Anything we can do to compress it?
>>>>>
>>>>> That's an interesting question, from the top of my head:
>>>>> pre-sort in pahole (re-assign IDs so that increasing ID also would
>>>>> mean "increasing" name), shouldn't be that difficult.
>>>>
>>>> That sounds great. kallsyms are pre-sorted at build time.
>>>> We should do the same with BTF.
>>>> I think GCC can emit BTF directly now and LLVM emits it for bpf progs
>>>> too,
>>>> but since vmlinux and kernel module BTFs will keep being processed
>>>> through pahole we don't have to make gcc/llvm sort things right away.
>>>> pahole will be enough. The kernel might do 'is it sorted' check
>>>> during BTF validation and then use binary search or fall back to linear
>>>> when not-sorted == old pahole.
>>>>
>>>
>>> Yeah, I agree and will attempt to modify the pahole and perform a test.
>>> Do we need
>>> to introduce a new macro to control the behavior when the BTF is not
>>> sorted? If
>>> it is not sorted, we can use the method mentioned in this patch or use
>>> linear
>>> search.
>>>
>>>
>>
>> One challenge with pahole is that it often runs in parallel mode, so I
>> suspect any sorting would have to be done after merging across threads.
>> Perhaps BTF deduplication time might be a useful time to re-sort by
>> name? BTF dedup happens after BTF has been merged, and a new "sorted"
>> btf_dedup_opts option could be added and controlled by a pahole
>> option. However dedup is pretty complicated already..
>>
>> One thing we should weigh up though is if there are benefits to the
>> way BTF is currently laid out. It tends to start with base types,
>> and often-encountered types end up being located towards the start
>> of the BTF data. For example
>>
>>
>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
>> encoding=(none)
>> [2] CONST '(anon)' type_id=1
>> [3] VOLATILE '(anon)' type_id=1
>> [4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
>> [5] PTR '(anon)' type_id=8
>> [6] CONST '(anon)' type_id=5
>> [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> [8] CONST '(anon)' type_id=7
>> [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> [10] CONST '(anon)' type_id=9
>> [11] TYPEDEF '__s8' type_id=12
>> [12] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> [13] TYPEDEF '__u8' type_id=14
>>
>> So often-used types will be found quickly, even under linear search
>> conditions.
> 
> I found that there seems to be no code in the kernel that get the ID of the
> basic data type by calling btf_find_by_name_kind directly. The general
> usage
> of this function is to obtain the ID of a structure or function. After
> we got
> the ID of a structure or function, it is O(1) to get the IDs of its members
> or parameters.
> 
> ./kernel/trace/trace_probe.c:383:       id = btf_find_by_name_kind(btf,
> funcname, BTF_KIND_FUNC);
> ./kernel/bpf/btf.c:3523:        id = btf_find_by_name_kind(btf,
> value_type, BTF_KIND_STRUCT);
> ./kernel/bpf/btf.c:5504:                id = btf_find_by_name_kind(btf,
> alloc_obj_fields[i], BTF_KIND_STRUCT);
> ./kernel/bpf/bpf_struct_ops.c:128:      module_id =
> btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
> ./net/ipv4/bpf_tcp_ca.c:28:     type_id = btf_find_by_name_kind(btf,
> "sock", BTF_KIND_STRUCT);
> ./net/ipv4/bpf_tcp_ca.c:33:     type_id = btf_find_by_name_kind(btf,
> "tcp_sock", BTF_KIND_STRUCT);
> ./net/netfilter/nf_bpf_link.c:181:      type_id =
> btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
> 
>>
>> When we look at how many lookups by id (which are O(1), since they are
>> done via the btf->types[] array) versus by name, we see:
>>
>> $ grep btf_type_by_id kernel/bpf/*.c|wc -l
>> 120
>> $ grep btf_find_by_nam kernel/bpf/*.c|wc -l
>> 15
>>
>> I don't see a huge number of name-based lookups, and I think most are
>> outside of the hotter codepaths, unless I'm missing some. All of which
>> is to say it would be a good idea to have a clear sense of what will get
>> faster with sorted-by-name BTF. Thanks!
> 
> The story goes like this.
> 
> I have added a new feature to the function graph called "funcgraph_retval",
> here is the link:
> 
> https://lore.kernel.org/all/1fc502712c981e0e6742185ba242992170ac9da8.1680954589.git.pengdonglin@sangfor.com.cn/
> 
> We can obtain the return values of almost every function during the
> execution
> of kernel through this feature, it can help us analyze problems.
> 

It's a great feature!

> However, this feature has two main drawbacks.
> 
> 1. Even if a function's return type is void,  a return value will still
> be printed.
> 
> 2. The return value printed may be incorrect when the width of the
> return type is
> smaller than the generic register.
> 
> I think if we can get this return type of the function, then the
> drawbacks mentioned
> above can be eliminated. The function btf_find_by_name_kind can be used
> to get the ID of
> the kernel function, then we can get its return type easily. If the
> return type is
> void, the return value recorded will not be printed. If the width of the
> return type
> is smaller than the generic register, then the value stored in the upper
> bits will be
> trimmed. I have written a demo and these drawbacks were resolved.
> 
> However, during my test, I found that it took too much time when read
> the trace log
> with this feature enabled, because the trace log consists of 200,000
> lines. The
> majority of the time was consumed by the btf_find_by_name_kind, which is
> called
> 200,000 times.
> 
> So I think the performance of btf_find_by_name_kind  may need to be
> improved.
>

If I recall, Masami's work uses BTF ids, but can cache them since the
user explicitly asks for specific fields in the trace output. I'm
presuming that's not an option for you due to the fact funcgraph tracing
enables everything (or at least everything under a filter predicate) and
you have limited context to work with, is that right?

Looking at print_graph_entry_leaf() which I _think_ is where you'd need
to print the retval from, you have access to the function address via
call->func, and I presume you get the name from snprinting the symbol to
a string or similar. So you're stuck in a context where you have the
function address, and from that you can derive the function name. Is
that correct? Thanks!

Alan

