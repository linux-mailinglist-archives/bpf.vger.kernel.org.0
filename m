Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84003F8C5A
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhHZQmR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 12:42:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229602AbhHZQmR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 12:42:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17QGcPSO026150;
        Thu, 26 Aug 2021 09:41:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=DcxKu08Lf2plNB7Ly3u0rs/L+I5DK9g1334SKV8gHGY=;
 b=oSz8/0tD52absmhKi9WGIsMKOxJfgjbRipEsK5Tz1tZwqHASnNRH7F/0P7rQ7JefZfVV
 KmKtwCUPm8ymum9HCobYqLrPXBk0MBu4RHFHojS1QZbm7zpNOjkn+wsNV2ibKCfiQdQ0
 Y6p71Hx9vKGrdQdUQtG5eUS9TD2ExS0sc+A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3anuusprac-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Aug 2021 09:41:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 26 Aug 2021 09:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UURyq4YJRB2y225txmrPIB9iDpU1YJky5e/B/N9PEUoP/ugOOIDsOu1817WTgnb/fQ6EJ56uKN2QFunUdr/nhQqDMTqyMpggEPKfGlPHzOgBIHyVmbdC+4pLsQXGL+phot0YgkE39DabMQySjHEhzp1+MbSOwVAEw5zVD6FY7yn2Q5QpC9rxWR14cS5XIDWOIc7YQLoig5qcb9enemiNDTANQ6BLgEJGUI3I5Ic++XqKgD4PEk7QSUa433m2ExX6qMu5RO4+pT9KgGs8+5AUdTDMpBJLsn/TCyk+s9H+WzPmWrhp94fQSBJsVzOix1G4gGStylDv7iO4fTAd8A/87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcxKu08Lf2plNB7Ly3u0rs/L+I5DK9g1334SKV8gHGY=;
 b=NNulihdKXTtr1sRewtOEihjOVZiio/4HyRpz9+VKj4vvX6O5yIlvn9KA+gZihyFu/Ja+4AXYdHl9fcy4+gefmzrpOmLF/P5gF1bmFcy2+MXPFL6NyPORQWxGkG6xHjaDtKgqrlrF0tdaDz40j3j1jSSltVHxKDzGDvgBOHrV2PY1vDMNFIZFuXddkUnXUhjsgCfQIhdrnSuvao5Y8g+XE+9/XLGpeGeybBvLXOV7cjgQEy2VtF+kptrvbdPCX421CYLzwxA6+KuFeTgnAyzTJDbTQ2BT/WYXxt7Z3aON0Zft+5Jn+U8D30Pms4jpkKrPvisyPYL4I5ScrepKJEoUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5079.namprd15.prod.outlook.com (2603:10b6:806:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 26 Aug
 2021 16:41:20 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 16:41:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     kajoljain <kjain@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXmK2W/diq42SVLkGzxG3mM7ps1KuEIrmAgAA2DoCAARWFAIAAkr0A
Date:   Thu, 26 Aug 2021 16:41:20 +0000
Message-ID: <A07D405F-45B8-43A7-9159-BE71F9069139@fb.com>
References: <20210824060157.3889139-1-songliubraving@fb.com>
 <20210824060157.3889139-2-songliubraving@fb.com>
 <YSYy87ta1GpXCCzk@hirez.programming.kicks-ass.net>
 <19CA9F65-E45B-4AE5-9742-3D89ECF0CEF4@fb.com>
 <71cdc0ec-1b58-69c1-eaca-631800774c13@linux.ibm.com>
In-Reply-To: <71cdc0ec-1b58-69c1-eaca-631800774c13@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd4b33d7-409a-40f7-dafc-08d968b05597
x-ms-traffictypediagnostic: SA1PR15MB5079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5079FA756DFE9DC0769BC938B3C79@SA1PR15MB5079.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acCyWwV+zhWJX11+uWOTHoqN5Z0G9vkNYRsmezyVSU/TxLcHiX2Irwx1gQjiaZHP6dem6LzNq6RmWJXUhU/cHP6G10qWr0kVTHz98Sjk4xH37L/X47IduamurdfBPyUKZDf/Jv0RinKC7V6I9/qlzLL2jTcoyX4PQzv9XZaDxppXK911K+xgQo2A170SQr/hgaXHypEpPMlG+dXavxY4YRQzNJ+ePD0T5rEZw2QUkiUoUuPrU1JI4+J/4QE2rrWT73UU6fMgwLDQDe0NJbmcgW54G/QGV96XCmu/v+qyipbcCI8jHiomZDWlgnb3TCm4XYEl2Pu4OzkobWJMBRIzduVSx8pIqhvfNl+yjIjehqzGuxExvAwTdlWiyfltXeNNDane0ye4scbd4AjpnOII8CKt4Dkm3GYUxrNQtP1phhTXj+LowwKT3vwQjfjAmFUEcvTVSnQJ0eb1DwXRwYXGbIXUdwMujG0pgNefVWy06s/B6T3QQuVONprtaQ4G4VbZQ7G7xRNqwr29dC4VNs04lw46PRokVTOCYS2jMlkCatBg0InTRdmgL1m4Nbljj+XNh1CzD767ajFffuGz0dWKH1QHLFjM1UJTwn+pRbL6Upwsb227KScbsyKKauhwb6jvQnuBYW4nCLPAO9Qdwbbwc1xEu/dv9Gy8apXaadgwcZWP/x8cwVAsW7E28H90OtSfgEBv3ywpXiIBJ4Kc98juzyMZS2j6Kj5lJjHbOdOK/9o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(6512007)(316002)(2616005)(54906003)(2906002)(86362001)(5660300002)(8676002)(53546011)(6506007)(64756008)(66446008)(8936002)(66476007)(6486002)(38100700002)(66556008)(83380400001)(76116006)(91956017)(66946007)(6916009)(186003)(478600001)(33656002)(38070700005)(36756003)(71200400001)(122000001)(4744005)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FGriFS+BAJLOIHxiVV8LszwRqHyl6htEPr89iM+K3iFvVxF3u8RDIbVwNgnv?=
 =?us-ascii?Q?nTReqYIxk0B1xVMdjJ4qBknzNZ4hlTXK81HyOP571QPVHCPY+a5q5ToColvr?=
 =?us-ascii?Q?mDou9InlgMbPSeV7oNpYYOlX3CTas6GJxD98ajwrt4JOMWTwVmVLhe2euTyT?=
 =?us-ascii?Q?W9FfuIFK6cySGJtr2icesInu7cOUpAFX2AQ/JRcAxR2vU2V/IzHn5kuAYHR1?=
 =?us-ascii?Q?9nHVJ21o+4xSmzdVRs2bCutqvxvKDfJg1JJchBpQZo81lLXjWbSFH9wTwOfw?=
 =?us-ascii?Q?3tC+Z6xYqrGRD/u234dO5rH3U6Gkh3S7XnwHp782h8DmgUqYhiovRvqCY9mA?=
 =?us-ascii?Q?NTXioop9v+heyVriLRV6F+jUYQliKE0i9mkmvHJRYDxNCoF90TCFK1DQlceT?=
 =?us-ascii?Q?bD3oa3YNmlFWXmadQjbViD9BFq6Uedm/WVl8Vo+DKXLq6ADvDUpw+9re2OkS?=
 =?us-ascii?Q?ci8fHD/fanrRr4YXoCk2u6TPtTjWCBJ+3nsXimFugpBFNRFQUqavWBRzq94E?=
 =?us-ascii?Q?TIXRn1aUrJyNguzhI6dhKCGNbXCBGu/wenX1u5i0CC8yRvnfzI+qSkH1XpdI?=
 =?us-ascii?Q?WCcllMFLgiDBSlJFYVsm2ZKqVcydqp00FadT2wTHNdkrz7LlelhRVryE2HT8?=
 =?us-ascii?Q?dyeY18FRtWrGSqh/lTqbXZehiXHmrbJL5Mxj8YrcQh89AFN+grOeJUC3MHIe?=
 =?us-ascii?Q?0jVdcZ+EyLvumvf9YXWCtltzS6md+MnyVJj3mc7jrelLKayu090C3vzjJp9h?=
 =?us-ascii?Q?BDj8S+qnbj9nljn64pcaIIN1a2murIvMzYnfq1AM8T5COoFu7bUZad+mw4tE?=
 =?us-ascii?Q?Atjs1z0fLd96eUO5/giiGnttE7f1TGbsALBaQnashJjQ201SmKfQmxFg4Ghw?=
 =?us-ascii?Q?sxq7PqpoEiXIK3SRGRB0w5gkzbnNk3uLkruMphJd7Not5d6KmN4s7zlRnB72?=
 =?us-ascii?Q?1xLe6+m46u7t3GK1mC8c1DbEFJiv/QsEDp1hrrQFV1YRbeKk4+OTBpL43oeB?=
 =?us-ascii?Q?ewbev7jY3G7BBKjGrcKATvWEbiUGLlUWrV/PThxfN/ApgcYaHucekikmYr+8?=
 =?us-ascii?Q?AXFQDbNltELCb15NKUEVMJ3f3lakDEcXSnWsDvbjRDqhPDEH01Yv1JDXhhJf?=
 =?us-ascii?Q?nMi2lL/RAcBsTx7dIOKh3+iyjOaLvZRwTLEgZa87Lqj/Us5WrLQkF2nR3eWD?=
 =?us-ascii?Q?et3qqpngcGc5ZbxBpZ+CmAnQEoZKGKLrsXTXv6i4ByWH0j4PCmyaaYaJNhL/?=
 =?us-ascii?Q?8LMoXwqTuocw7hCgYFrKghcBHacs/+hNgk/KCyGyiVAb9V+ZpF6yCGhImddD?=
 =?us-ascii?Q?SPqG7RV0r9PqkmAOf4obrcHNLAbxgMw59b+N6brza8mwl+TNEr4y+kxL+Cod?=
 =?us-ascii?Q?kPPhsfE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <045130DE3A355A43A5E680154434CCE1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4b33d7-409a-40f7-dafc-08d968b05597
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 16:41:20.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCFUrlwd5XPj3q3ke5HfN4k+VwR1VwGRzahDagGZwfZ44HDBRRKEzg3hg+stDQailMqptik2e5Iqfz/7Ljvmtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5079
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Z7-LmVG7P_AOSJ_TKXJ4RiZzx9RojrFW
X-Proofpoint-ORIG-GUID: Z7-LmVG7P_AOSJ_TKXJ4RiZzx9RojrFW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-26_05:2021-08-26,2021-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108260091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 26, 2021, at 12:56 AM, kajoljain <kjain@linux.ibm.com> wrote:
> 
> 
> 
> On 8/25/21 8:52 PM, Song Liu wrote:
>> 
>> 
>>> On Aug 25, 2021, at 5:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> 
>>> On Mon, Aug 23, 2021 at 11:01:55PM -0700, Song Liu wrote:
>>> 
>>>> arch/x86/events/intel/core.c |  5 ++++-
>>>> arch/x86/events/intel/lbr.c  | 12 ++++++++++++
>>>> arch/x86/events/perf_event.h |  2 ++
>>>> include/linux/perf_event.h   | 33 +++++++++++++++++++++++++++++++++
>>>> kernel/events/core.c         | 28 ++++++++++++++++++++++++++++
>>>> 5 files changed, 79 insertions(+), 1 deletion(-)
>>> 
>>> No PowerPC support :/
>> 
>> I don't have PowerPC system for testing at the moment. I guess we can decide
>> the overall framework now, and ask PowerPC folks' help on PowerPC support
>> later? 
> 
> Hi Song,
>   I will look at powerpc side to enable this.
> 
> Thanks,
> Kajol Jain

Thanks Kajol! 

Let me address Peter's other comments and send v2. We can then merge in  
PowerPC support.

Song
