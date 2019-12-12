Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0211D4B0
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 18:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfLLR5i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 12:57:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9774 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730034AbfLLR5h (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 12:57:37 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBCHvGd0029860;
        Thu, 12 Dec 2019 09:57:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HObyIFnuvys7luGdwPf7lymuLI0adEIZ6D6WPny+aWk=;
 b=NJ3JOC3+zv/6kjAcD007WOaaeFjSzaW3E/lH6CLczcumoRQ3pahI7ITebcl7xY86L6n/
 h+b8aYedQC/iL2T7k1wxKu8S2hF518LeblhM8EaWxSxsD90t9Jz5hzk0wAg7JUJOhrKa
 Srkb+raSUS4+KHFuhnfz4D16+zNqel7jhv8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2wu5w954s2-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 09:57:23 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 12 Dec 2019 09:57:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 09:57:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f52h4Mb6gq74knY5K9RZKGTHqZgk4KoWH4GBrjuPaa0+L6o5r/fgNw8JAgllzdPZkKZjTcT00DykzgFAWYv0tmoZRPi20h1v4T0wBqmXStXwdSXunED9O8bFr2p7mDUh1bx6EreaPMFh5MAGPH39FejqVZKzO8JMqkKaGyIVKDtJnDF7+hh/1YFbEf3Lchzq1HApDLmW83IraNS7WeMOmQTR/oLg44p4ZEbWV7O262YETr6fGDAcWP6BB4VVd4f+dpHLa1Rl83nxjFRhdj8MggFOICdSuAyoniPGr0Vu6rk9V24f6qKDxY2mO/JQh7oO4xNvlmFeQUd9Pva2ni23mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HObyIFnuvys7luGdwPf7lymuLI0adEIZ6D6WPny+aWk=;
 b=Wny5Q8jEow/nUY24PWLajAhlt4P0QRKcijzSd/mLeM5ZVktzM+jBqHFz/ye/z4mFqtuR1+2ss4NSy5ihIs+Iq+Uh/2Ik0wKhtSDh7Q4GNoIM6/QNm06Rs8zW6l+1gSvMM4zJapURaSiZl9wD//zwyH6JnoaFOvFnkCKBk7mTiKyxYwpf17Wv+u92FHXmgdYwe5oGzYn9m16VzrldL5EXAD8D6rEOZ4T/SF4XEhHWLgrHOcfM3/hX09yrl7QJKRxpty0lwEd10I8zNhUusR7ElDm/355Mt9bEs+eEHbMU0W/tj126cOcs0fT4TxGcF3NsaaIdKr+BxOXb0scJF62aMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HObyIFnuvys7luGdwPf7lymuLI0adEIZ6D6WPny+aWk=;
 b=Bvib/QJOhlfFCGLWhSUjnxV0JIi6LMsDl/XYItFq5ZhX9mU48AqyqufEF9auc7HtP43CK/9gHHdLJKyu8a/zRT5y1JsH75Wp3am2dBi4WOK0h7BUeI8SSjIXw7cv7/i/+ZshodpP37CRwYF2bCC7SgTYTVbKdyYSdarpdI4i6qk=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB3535.namprd15.prod.outlook.com (52.132.172.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 17:57:05 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 17:57:05 +0000
From:   Martin Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Simplify __cgroup_bpf_attach
Thread-Topic: [PATCH bpf-next 1/5] bpf: Simplify __cgroup_bpf_attach
Thread-Index: AQHVr8uCYRBcWLqvEkypq3DiiljuoKe2y4SA
Date:   Thu, 12 Dec 2019 17:57:05 +0000
Message-ID: <20191212175701.zqnbf4vnfdi5rc43@kafai-mbp>
References: <cover.1576031228.git.rdna@fb.com>
 <555e684ef08c2513ce71fc0e36edb2986bb7f7b0.1576031228.git.rdna@fb.com>
In-Reply-To: <555e684ef08c2513ce71fc0e36edb2986bb7f7b0.1576031228.git.rdna@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0028.namprd21.prod.outlook.com
 (2603:10b6:300:129::14) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::97ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1951784-d1ad-4002-bc54-08d77f2cb2cf
x-ms-traffictypediagnostic: MN2PR15MB3535:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB35352C8352F76A8657D0B030D5550@MN2PR15MB3535.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(9686003)(33716001)(81156014)(478600001)(8936002)(81166006)(52116002)(5660300002)(6512007)(1076003)(186003)(4744005)(86362001)(6862004)(54906003)(2906002)(66946007)(4326008)(66476007)(66556008)(316002)(66446008)(6486002)(6636002)(71200400001)(8676002)(6506007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB3535;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: teQpvxnkNobOzS/cBA7akagSrKchGQmDg84jUK7VawKNqdaqwQ4AADaGuHT+kFybXq4UgUiwkYbq0eyKPRS9b6m8a62v+5Vl9bdHYVxTl/P/shAbJkfoEPwnD75pO0LQ6gETiAmeDmLZBE1UYoxUd/VZzr9YWYUUIbcaB5bOZvNvzwIcERr2ZUhjhdOX+BkTeS35VdLuUsLrDXyWq59S/zCU4qHlkU8KJFi5rwB74uxduTaXVErqU1HOO+6WbaPLyULcYhr5EZxX8Bj/x6z5SirZQIejNAr/4r/yitMAdp4DAc1ZNU/dJrDDKf8fc16uoQh6O/6BJSi3zNve5Hz7eYcDlNoeBdIITKVCNmcBATIe1LZakYnB4cFSPzKqPev9MEshjOBqjlv0dPxDrJvSXQSWo5PAsmkA97pjUe3b2VYpopBo91hdPQYMVNaZ9qvy
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28AA7816CA32EB4D86B8E5C1D643791B@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1951784-d1ad-4002-bc54-08d77f2cb2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 17:57:05.4230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YAuvS8MyAl+vzOJpMYH7gDX14HruAX/iCU7ELr6JjPzhThaUwL+JefjCi5h7F6+G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3535
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=686
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 10, 2019 at 06:33:27PM -0800, Andrey Ignatov wrote:
> __cgroup_bpf_attach has a lot of identical code to handle two scenarios:
> BPF_F_ALLOW_MULTI is set and unset.
>=20
> Simplify it by splitting the two main steps:
>=20
> * First, the decision is made whether a new bpf_prog_list entry should
>   be allocated or existing entry should be reused for the new program.
>   This decision is saved in replace_pl pointer;
>=20
> * Next, replace_pl pointer is used to handle both possible states of
>   BPF_F_ALLOW_MULTI flag (set / unset) instead of doing similar work for
>   them separately.
>=20
> This splitting, in turn, allows to make further simplifications:
>=20
> * The check for attaching same program twice in BPF_F_ALLOW_MULTI mode
>   can be done before allocating cgroup storage, so that if user tries to
>   attach same program twice no alloc/free happens as it was before;
>=20
> * pl_was_allocated becomes redundant so it's removed.
Acked-by: Martin KaFai Lau <kafai@fb.com>
