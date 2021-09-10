Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3914071CC
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhIJTYA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:24:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35990 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhIJTYA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 15:24:00 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AJ4nSP001874;
        Fri, 10 Sep 2021 12:22:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=0gRbW/sdA92OS2VywHbZmJVS1m3uEbRHtGuQAhlD1tY=;
 b=hasBpgW0FG8FjazlU7gf3MxTHfNhFkEC9Zo2r8vNg5XZ0DyoXc+OSGkhstpF8m/OorgF
 vyuRetmJ3P20RvjG5TgvUO1XMI19u6nA0K0yEOO1W2XXby/JJZ4Dgxnbzsp8XjbFKJiM
 ZZPvqfU5YNabVN8YUzYrdLGnQcbkxyVd37M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytgk70ra-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 12:22:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 12:22:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNkgi0bOiXO6Ch3toyQdSAASi8nPOd4y5z/txKNrtVDtQY4DGxWXVhmth1BShrS0Dv87KnCnlcfp6BS4v5xklvbpSmIccmlFe5ZorlF+Eg20CfvuKkX9Nd0vuYo09e5Mfp/AXHHPL2luSEywMPNk98FXKOyveof4QqEKPOcRBSRWZ9rYixAgvI0IJlmkb1cbHz+9NfixBYQPBGUC2RblyYz0/8QAXUqWL+A8+h7GdZrDdt4j8mFunAaBUh7zJNAKbxPNjarvIxX2ojCveo6GBXwYnBPC5cBZH72q38RyFVsggKhHz8FnA3iouwhsB6u4n0weW0WFaUw6HMmNF5haDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0gRbW/sdA92OS2VywHbZmJVS1m3uEbRHtGuQAhlD1tY=;
 b=IxOZ+8sWl12IWDWHL5I0yFy44MT0kuyqI4ivdCvc3Z/n8DB8mw9pu11RE9Az9JjupErOmvk24u6bFHkiW5FEKi36QmptuclfBWSqItbpy1ZkK01QbVC6AmzB01oBwjE0dwBlXI6X3YOmzNOzCYXpvXP4lWS6nWGrGxyUMUahUGICJcmDD1dQSGkDJ8MjqvyuFGp4f4i+B/IXw2gPxUrvM1YztB6DEHRg92qkvOiGAyz51cVx513m8LyuVY9QZJ/reTTDvkS022pY/eDc7ciRapuUmAckzLEA6420w2Ryhxm/sOVNed93p3gUJgGFH6CAy5fcK05Nl93HgVd740os/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5096.namprd15.prod.outlook.com (2603:10b6:806:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 19:22:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 19:22:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v7 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Thread-Topic: [PATCH v7 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
Thread-Index: AQHXpnJw3cUeQuogOU+pppm5WBnz7qudpY+A
Date:   Fri, 10 Sep 2021 19:22:44 +0000
Message-ID: <F55EC51C-BF94-4FF7-BD1C-9CFBD222EF5D@fb.com>
References: <20210910183352.3151445-1-songliubraving@fb.com>
In-Reply-To: <20210910183352.3151445-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf3c89e-61d6-45ee-4693-08d974905dc1
x-ms-traffictypediagnostic: SA1PR15MB5096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50963B93D1045D75B00660B4B3D69@SA1PR15MB5096.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUqmo0SqPymu4sf22iEKidq6w8tWUf8nSj5rw7W6+32cy23Miq8X8Sr0FhkhJer6QXVPZCEHJxnx+wyYEM3ivWPetxrF9s0N2hLnslG8f9mHaflxinYHsxK0+Luseo03fdFPesBf6Vz1b32V+xlXFl2KHbN3yAjRHSY+ysqXP2jHa9HKyr6fmjNgBllDecsSDH0kT/dY+TP/qk3t90QFyetJxLmA9WiKka5eyegr60p/lZSGD+g/LZeK1gvrVtUKNGavO0bi7J756XL+ENm2HcwNXM3wMwGlfmkrxQvEOg24G3bEltjBy76SRmh4qzJt8UPdU0ppsBoojZBcx3yUvQ2apBcUc8KETpTQOhrxvYQQToz0RNMKeIAzGbhVk005a8IZp8/aeb+dM/4mQ/8FnkpSllfi1vpPEnEZFPLVyhbj+UqUDSCnvlBMrtn5mIabIdIyfVCJik6aDPKF3CUPkBDjftRpPkb+lKtaXeCIrm81jB7bYj9TaVdJ/a+6YgQ5fMj+Ei1hlhdIYntteeZ9R1CFl+h0qlT+mNpuVVHbOt+gE6jcgmmSSvLYEXPq4pk10xQhpgEQbM/RGgL/ewpTQy9ECWNwO37sI5KHkVtbJ3Je/HuiVNIdI+M9VAan28HZQupPIrqY58ZKzc+gxUvuCHbgEaYlnD/GgTVlu6kHAOFN1yw4lVMGwjNZTUaBgvxetAKymojkZ+B+Pm+DQJcE1ksu/okVV1pbShI2wpFERKg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(36756003)(66446008)(316002)(71200400001)(76116006)(38100700002)(6486002)(2616005)(478600001)(122000001)(66476007)(91956017)(110136005)(186003)(54906003)(8676002)(53546011)(2906002)(4326008)(38070700005)(6512007)(8936002)(66946007)(86362001)(66556008)(64756008)(558084003)(5660300002)(6506007)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dY2USbAvtvcfxLGhv0H6zPubTtaKrSGrj9JpIhzxPHOnVc84Mh/pU0OarjoC?=
 =?us-ascii?Q?I3DBH7qfRgShfIYt/dAd39C707gXZ3J+8HWwPedblWwZzkIoszkFvQVQpTwN?=
 =?us-ascii?Q?KcJA4RHc2ymVYFdcd+FNsJ7dxcrvAAYZSx6GooNtoVI0c+2uWytZK+uFs5In?=
 =?us-ascii?Q?GKCvbUeRPq5aqxUwDVyeLy4FpNs0u3h/3MvtTiAPA6NbjnNrbJ3sHK1q3yRJ?=
 =?us-ascii?Q?AkAdbyOb+soE3SlMATm3cfKELcq5vwyvMIT22ptsWVKD3tZVyLjOybFzfdTv?=
 =?us-ascii?Q?6mXCOa7BGgZHASSX+rpLzQuCWqb4jqzCAE65UJAwYx3g5JUkzcAm3MvvsntD?=
 =?us-ascii?Q?08I/GVXbTOf2ljwNUN4McplIBxHAsk3lc3hKF2lN+hS5eraSXZa5BbbLnDFc?=
 =?us-ascii?Q?LiA4xCOiiagSrqtJ33oFE9y027vsgV9+szex+NTZ9jnwgojFYQWYbwiOKcnz?=
 =?us-ascii?Q?V3enh5yBNHb2WuBCFiWHEQMNlEY1e8Zl8Kk8RyMcfyQ2HrDV/UOIOJLYi872?=
 =?us-ascii?Q?EUN5mnodRHWz6Xtpqn6MGGYVEmVHVJDdjqFBiQ3ewuBbDndfn6jXEsLxnvIq?=
 =?us-ascii?Q?Ke/e+LrsUXsPIL79yUVXvc60s5XdhidERLkva+Q43R/S9itKFjlkDby7c4it?=
 =?us-ascii?Q?c5ZtAkSRPeDxyRCXv/cDu5V/a1U7VFR9vQHpskGV8NQbDEDaJ4QLzqvtwF6k?=
 =?us-ascii?Q?V+6SmN8S0Zekc27b/MhTU1BGL6nAZLM4p5Jh50WPVUwtusy44GT/zTX5GEZS?=
 =?us-ascii?Q?1AcjulBdHMXnYu/1GosZqhtSHpWua2urotlqb1cL6qHOEFVmpgZrpvWAJc3M?=
 =?us-ascii?Q?CKneD5XxOcPVmlF78y3NoSBgk/+GX+3TevdTk31mhUWLmEW9zsNOdZGcSu9W?=
 =?us-ascii?Q?SkERItPuL1lxadA2fm18sa4bV9Zu7hMXr+htC4eiEb+oHBmzmKIk4tVm+baV?=
 =?us-ascii?Q?IdCcyvTW8eQawDrDty7Xd/oy0jxpC8pohSG46uxhDe/aWINUFqkR+qCBy1Jl?=
 =?us-ascii?Q?GgajbebYPO+avvJB44yAhxqNBEO2JEFQ5j3R9C7gbaUzjTMbGGlJDPEXiggJ?=
 =?us-ascii?Q?Y9E7ba3N08tDQaq6B/azIQrozpERllc2uQSInsg8uqIGXR9u1FckWP38leSG?=
 =?us-ascii?Q?uAyOGVMAeRVGxWNVw45HI+bcvkTsv7JGl7D70QlqCRFEuNwCMdqFLdb8QpMW?=
 =?us-ascii?Q?cD9eRyEdTDdBiSFPs07lJDfFqjhA/AC9QUn4aC+8yE1J9MG2g9YSPegGus7F?=
 =?us-ascii?Q?JL1gEgdEqD4M0ieGxseazW+KkPzr9+7iMO5H6ha72+13Tvuh5Nj7CFlakRVG?=
 =?us-ascii?Q?BB/ofCNpzOgX00DrtSmD5rr+FKEE07jfWy1GyXd0Cys5Hijj1BLXnNSJ5rWO?=
 =?us-ascii?Q?2Mp8vxo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE2D8692F3C89D4EB0E21C0DB0E689D9@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf3c89e-61d6-45ee-4693-08d974905dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 19:22:44.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIf38xizgZxnvthCrm34sxO3b/fh8jk8Bkbwph2pgyVX2y0VTYag/uQUwzvn9/47qyaMUh6PXYXwiAdYgYStDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5096
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: C2Ur4F20KR49vJvLUJcqM1-pPj8xSSQB
X-Proofpoint-GUID: C2Ur4F20KR49vJvLUJcqM1-pPj8xSSQB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter, 

> On Sep 10, 2021, at 11:33 AM, Song Liu <songliubraving@fb.com> wrote:
> 
> Changes v6 => v7:
> 1. Improve/fix intel_pmu_snapshot_branch_stack() logic. (Peter).

Would you mind reply with your Acked-by or Reviewed-by on v7? I will fix
the comment in the selftest in v8 or a follow-up patch. 

Thanks,
Song

[...]
