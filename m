Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD73C32C218
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhCCWzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:55:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1388008AbhCCUWc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:22:32 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 123KHL0M021704;
        Wed, 3 Mar 2021 12:21:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=2miiQUDZMksBmhJqtuZHfeIdFJaJQ8yg+zpZeabC/S0=;
 b=cAOkMd0ic6BCy6zqN+rKUU3GND/u5CUVdYpx/CdZNrleg+jmIljuMuPOu5WUO8sQaxv4
 R7OlABPe6Yg3afxApc6Ao9pWlHU1RMv8I8NSAHdp9GVGE0w9jSS4yWoVjeBJOds6sl36
 ybZ4pm+9ss9HH3UsoTzFub8SeqM6dKO6eXw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 371uu3pp4d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:21:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:21:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMlVs096yV5movPO54b+5WU6WizBQssMiJ0h274792uGFofHpBW0JWg5f7tnvZDArMtl/wpwGhhj36BKOYbmZPdmcawSmUo+PrL1LnaYrIDIyEFRr09kqhZku1Ipc1fSwK0g/yOl22pFtQ2ObZXPe/4wj1fFnKgGkpR3KJud4Q/57oA3OwzwwHLSvJttfhCmQLjWE10bXc90hDnDJrO9YBTDdMLs8RkCXxMTfKrxWLxs2903XQlYcgg02y2JyOHfnMDbpimDXL/n1z/3y3ZkMIfz6QjcgGzJTXl++PWmJ6ZxifqaCoqhMPkgYnsKphVHo805OVITDrTaiboDf1u/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2miiQUDZMksBmhJqtuZHfeIdFJaJQ8yg+zpZeabC/S0=;
 b=Si2Z/pNSi19zRKatQeYp6k+Y5YlqzXbA60kUKDBu823A4E5TQhSBiqVxc31FizJj84isrgovAxOf8rpV1v1P4PIVATtRIaGZfBiZ1g72H0bfcuwPHsIB9I7vxROPlKq4w3ETKKKQ1I8K/0IrxGlCeWRO2cN01Seur1dC5TYzrTF4NIAOpR/B2jdqQ4r7DrC9D5E/EbYoAFRtTtrAuLDraAYgh7tzTKRgjhs0IEP43P2tNMTPeWTlEm6COGNol/mrB8a/xXsAFDdevq3Zm3yW1bn83neOkALFZ5rNxcIcejchwG2PEbkHOyO79AJip/ewMv/3EcEnvVKlxNO4vY2R5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4222.namprd15.prod.outlook.com (2603:10b6:806:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 20:21:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:21:35 +0000
Subject: Re: [PATCHv2 bpf-next 04/15] bpf: Document BPF_PROG_PIN syscall
 command
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-5-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a2df3799-bf8a-7753-4c9c-0feb102cd643@fb.com>
Date:   Wed, 3 Mar 2021 12:21:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-5-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MWHPR12CA0045.namprd12.prod.outlook.com
 (2603:10b6:301:2::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MWHPR12CA0045.namprd12.prod.outlook.com (2603:10b6:301:2::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Wed, 3 Mar 2021 20:21:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87175137-755a-46aa-72d9-08d8de81f120
X-MS-TrafficTypeDiagnostic: SN7PR15MB4222:
X-Microsoft-Antispam-PRVS: <SN7PR15MB4222D77C5F876D950D505CA6D3989@SN7PR15MB4222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vD2T4cycpLlUymEAc5KCp6dQ9SEu6irNWkM+KEiwQgLqM7g1b+zARziKKaePLuXJK7InJJgB3faP2S+pKuiX4mjMU2skgyvfpu9jEFHd8h63iVQHV43Wpueyoci4J/EMoWA9GJcB0pAQIyyabx6RGPNolLbCf1QyxS6BrSSYuoGRLWLddXzgOkWJ8YRh4OoHu2yIDAJ+590ZV8Ffya3FstJI6CRaMOzC6VsOuWUkcgnVlscBkwXxKHqg8fBONJnMCUOtM0AdnBIydkJzHxJOT8R5VD9LZpJ1fCXD4tSUImcRHrHVUwnctWX1ItSv+15/WtgzhLIucRROqfAwRQjB+7Bq0CMjpCB+v+2p8ZbgUH8UvwXCSdEBM5M2aKWbMhDHllF1hOCRO05FaWuLiu44h2edhI697sn/uii9sNnQxy8uRB/D15Yk3cI1I3LhM9vew/fGg6/jyZpVdXPwnkHJSY8flZByyQKE/XAVPW1h22o6E/XTCNm3NNWdPj8Kspo+a56UUrJorZ1JhSRrJEv92k6dx99wdrL6+/0fEsTcurKagfWDutXG+9bBxLRN30+8chZWrvyn/aH0lUIBAAzp26U9PF25RTqhGl2Ccbfy88E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(6486002)(66946007)(66476007)(66556008)(8676002)(186003)(16526019)(5660300002)(4744005)(4326008)(54906003)(316002)(478600001)(2906002)(8936002)(31686004)(31696002)(83380400001)(36756003)(2616005)(52116002)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RHk5aEFuT3Z2aFZTQzZKZGsvYm9nQlpmeCtqRUJxZTNjZG9odlVyRE9EUm5M?=
 =?utf-8?B?TXluRTNWZzBDYkZzYXZDNlBzOHNlTUpJQmZ0MVRXNjNBZkJtckxCZ3U3ckxa?=
 =?utf-8?B?dkcyUnFWdmF5MURNR1NtSlhjQm5UMHRZQnhJK2lRVEF0NHZSSTgxQ2c0eUtt?=
 =?utf-8?B?UEdsOTNERGpaR3dyaEFabkVyWmpPSmdpRmVQMnFHRFN0SWVHSXZhN29UMG45?=
 =?utf-8?B?ekhJelF3a1VoM2NUYjFkMklNT0N1TmlBQi84eVlkNHdxa2lSQjZrZjVHVXNC?=
 =?utf-8?B?QjF2VHRkOC90UzBKMmNHNWdIb3d5ZjhBbXlLS1JVczA2eitRTjVFUEp4SWw1?=
 =?utf-8?B?VlhxZ1BMUWpaYkZwSmZtZm5vNXI2UjhxRndwVXBNa3cwbnBIblY3OHBWaU5Z?=
 =?utf-8?B?S3hneDh6dk1kSnZSV0NTM3hyVUs0Tld3eEQ4a3ZMSkRSck9HbkFRbHFqdFY3?=
 =?utf-8?B?aDZFaDhJUWJHZWt1MmxkZUdxaVFDdVFKS2tnMUovMzh0cE5JOGdVRE1ncnNo?=
 =?utf-8?B?aU95Mkp6Z1BYWlkvR0pwSi9reDNjM2VvYVRRamJ1anJrMStQTXNXVEcrdmFn?=
 =?utf-8?B?Uk5sSXlMbHpoZnpheU1VeXRRbVdSbGFRbm5VY1kvSDdCOTlOOUkyRzRzVUl1?=
 =?utf-8?B?SExKcVovdUNXdmRySm1TanVEZ1VabEZ2RExpU0ErblZZcC9wSVNkUFNhVjN4?=
 =?utf-8?B?SGJIWWlidFJERkJhSGc3VjhUbzBrclMrWEswbTg2MG5LMVFUTU5GOVJCblZ0?=
 =?utf-8?B?Z0RpN3g1a2tjdGp1S3dOM284RFhMMzRYRFZxbzZUc0hjdTdiU0RXcW0wOXhJ?=
 =?utf-8?B?WGQ1SXRhcU1iNGV5d0NkTUhRUU43YnJQNUQxNFRRVWFBMWpEbWRJelYwMC9V?=
 =?utf-8?B?eXJSUE41K1Nrc1pwLzBOOGViQUlqSW5qc2lxbitHR2dRbStSZ0hwN05lUGFI?=
 =?utf-8?B?aldwbmUrUzR1RlQvSmROVFhRNktWQ3JxVVRtL3kxcWN2NHp3VjIzVVcrMDQr?=
 =?utf-8?B?ZnN4TGZKUUI0Q0RhMHVyc0RLR3E5dWw4YzZzc3JwMTcvYWFEZUVPNDIrN1Iy?=
 =?utf-8?B?ZGNwTnVFWkFlNlFiSG9xa20wa3N0WmZtQWgxMjR2OVBaQXRaQVJDaGJxWUxm?=
 =?utf-8?B?SUlCTXlwVk1qcTZsMHlRaFRpZXI2dVp3QVpGUkN5VGVXOVJtaE0vdWtQMGdw?=
 =?utf-8?B?M2hiQ1RNT2ZjUi9RcHNzZ1QxSE40Yjl1WVlIdG5kZGFCT0lxczgzaWg1bUJj?=
 =?utf-8?B?QVVOKy9ONEVzS2VWd2llM01mS1F2RUx4Y2RzNlo0UEZDd3laMlhIc1F1R25X?=
 =?utf-8?B?bXVZU1JoQ3Rma3p6dGV5VWMzcnZWVHlIbE9ubmlOZmpiSi9XczNFeE1CN1JV?=
 =?utf-8?B?U2dvdkFIQmE0Q3VNU0h3K3czazltbXJyMzdNUEFaRkswS0IzWHRGNmFYcGpZ?=
 =?utf-8?B?SjhwaVNDNUJMYmdvY1kvUTEvQmJ0Qm9ML25SRkVtamYwelBKaFZibkU1cTNO?=
 =?utf-8?B?OVdaUEdpd0dHc3ZmLzVhSUp1UksvQkQ0UElDeG1raDB2K1k0SDhLMlcwNXlL?=
 =?utf-8?B?TTNjUUhRY1pVN0ZWemZOYlJXR0FTMThuMVZXTkpzOUx6Rk8wcjFneXhHWFB5?=
 =?utf-8?B?d1AyR0YyNktqeENWcHQ1RlRqRGRnL1lUREIzWFB0a0FJNmVqc2dMa0t0bDB3?=
 =?utf-8?B?bkEweVZQajFxUzBWRWlVaVhUSCs3NlVJREtEcVdLa2R0eHZ4UUcyVUhldzdN?=
 =?utf-8?B?Vm51YkE4bEV0eTRnMlZWbmpSUE13eEgwNWZCaW5aak5yL1BpdmJMTEhxT1pi?=
 =?utf-8?Q?Pk30cexMA5W6JgciD2f4VhdmG+vPnpcFqDYcA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87175137-755a-46aa-72d9-08d8de81f120
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:21:35.1407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7TCh7ZKVsjt64btdB1nyx1AKTEvKPEjhMv/y0ApFtEkmtVXnRmJshhHR5zwC/qH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4222
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Commit b2197755b263 ("bpf: add support for persistent maps/progs")
> contains the original implementation and git logs, used as reference for
> this documentation.
> 
> Also pull in the filename restriction as documented in commit 6d8cb045cde6
> ("bpf: comment why dots in filenames under BPF virtual FS are not allowed")
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Yonghong Song <yhs@fb.com>

>   include/uapi/linux/bpf.h | 36 +++++++++++++++++++++++++++++-------
>   1 file changed, 29 insertions(+), 7 deletions(-)
