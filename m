Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4392388843
	for <lists+bpf@lfdr.de>; Wed, 19 May 2021 09:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbhESHnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 May 2021 03:43:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65430 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240620AbhESHnI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 May 2021 03:43:08 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J7ddxg003953;
        Wed, 19 May 2021 00:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=amSC5YaAmyVjDAGBT//o7Xys1sKcvt2u+qwMux3BUus=;
 b=bF+u59NovUbr7P+Ctld1mzRp+2JQNW894GiaZWCt7qAaepGKNt7htiP/r1BblTaySZMM
 xsBSK9oCwdwaoqFWwyGqONTXiPTjT5CksM/WIxL8Kb/U0Sp6di/kuKZb21s8ocRB+il1
 Q7S6bVEi55vpa5cdHti3IC7JaLDEbu16RBM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38mf8mcxn3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 19 May 2021 00:41:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 00:41:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ai+tsX/FZpYRd3wEJ0r0fJt3WnJVIKCcn0Ffa4k6O3lkv/BH/KTFjOl7wWvMOv66h6pPauWneK6DQnupXWeZ1nFtWvZBJ076XAGQBF9lhU7Gjh9Vl6omTSXRx0CUIdmmwhlV8oBceJsjZEk/x5T9hEIriva2N4crzpmymjwTQ0wZ3qb3RFuhqq9SxOrA0FJa50ocJaFNF9GDg72N0e6h3gQ4Gs5aMrTi7V3Oo++b3MDkXazTlW4Ewo6mV/pm7P62cteyPoXCrcDy6NaxXCz9GJd+0XPXwD8DDbQkGdHJ6T7EPdNt+yPYUz2ys5VMbThj5Mn0S9qwx/oNQw+rGwRAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amSC5YaAmyVjDAGBT//o7Xys1sKcvt2u+qwMux3BUus=;
 b=JSMSUlpQSAKYtYETHaOwHEaSPHHIPlurgwieYm9vjKXu5b6Vg7LtTKkDQcJSkOLkb+twl6soxwoSvHzT1hDAYUZoUpHb+fe6ar3JyutO+uxHcM3PiuZavxmz796nE+NNyz1QUQlbxDt3DIW6U6EPoZ6YIiIUgGEysL3jHnzlDy3e+bKlezat618e26+0j0V2zb9JjxbdRf5+gs8+i6lNlcFlJsWxlQ3L8kcaafTTCCcTVEqd+iWuwM6Qyrq0cKgRkzKQtRFahHnHjNRVfkFtgaTsYqwlqj8HR4MWqLmbjjC0GUpSHnR5Cw8R4VB5ckRzSSgZudXWvS1DCQKVlm3KfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 07:41:30 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 07:41:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add cmd alias BPF_PROG_RUN
Thread-Topic: [PATCH bpf-next] bpf: Add cmd alias BPF_PROG_RUN
Thread-Index: AQHXTE/5DufBa+hHYkOMY/Jb3b1mRqrqbCKA
Date:   Wed, 19 May 2021 07:41:30 +0000
Message-ID: <F6B904B1-3773-4FC4-AACB-AB40E73CC024@fb.com>
References: <20210519014032.20908-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210519014032.20908-1-alexei.starovoitov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:fa93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 623ddd91-3250-4918-dfe7-08d91a998463
x-ms-traffictypediagnostic: BY5PR15MB3570:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB35709C9717E18DDA59304549B32B9@BY5PR15MB3570.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pr8okgwB0vmyAX7APZ+cUNV1JJUvYd7l2KhexYIZ6fk2MKTW8uMToKbFXzeISBrvEgp1B7RFEjqIhF+vR40wCTLwWCbcS0eayHdaOYSciFmtM5T/L33C+SB5nPwHIyZfpQYMx8CY+t36ck3Loi9p4ccmO0qPHSl/i3MdPL0gIj7RKyA3objBM3o7FYYrgqAQbez52vZ04XDNH5gVYSP5LS5ILl9PebbGForlWTervTY5+BCVHxb+Nd9v4l+6fxDNYbkVCe6dMcGK5f8zhpI73mchdcLvL90PernLFVpEEufAyLYBh7bsf8NR48ORojZnZT84xY9VagPx3T67TYoi7u5iQw1EvSvbez6WwhPIqJYeuK+eQRaMp39rlQj5ASHLXlw7yAXa8JJfac4YuCpX86trX0NuG73ePrJ5sLLzs/jtP7n703zi8+iM4ouAnws6R08vuY1tdTo213eUk6q/Hf6NfGzoVdVhI+ot1wJv5cAEQXmE6StKT6ckd/QJgSu7IJyPYQRdXKQ7k57NA25JLv6W/QHsTFZ3Yg3CY+L4YceM5j25EcOcb7fT+cuQ/3pXhok7ZE1qIV57/XvzP2B7Ctga48zff9wEuxnP2vQaU8unbuw/hc6dsZABjqixL4KOm2+PGNNCBe+EjGi7mWsmYNTgbXrp6g/afxCfYPZ4yDA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(366004)(346002)(396003)(2906002)(86362001)(38100700002)(54906003)(76116006)(122000001)(2616005)(4326008)(6486002)(8676002)(6916009)(6512007)(8936002)(36756003)(66476007)(91956017)(4744005)(33656002)(186003)(64756008)(478600001)(53546011)(5660300002)(66556008)(316002)(66946007)(71200400001)(6506007)(66446008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Eq3gtnvkDBnRfepiFF6ytRHt3RzZ9SUcIMJJGEZ1lLELB5OVlL5om7EiJOn4?=
 =?us-ascii?Q?ZOITGGzk5ZxGsLiBvaiGzcDk/Qekezaxt3xZIIzCwOG2UD1NG9Ah/i1xNV1N?=
 =?us-ascii?Q?vw9dAg1StulZ6ILO/i5OoENZ5Ga9lEqrX6n0z0tYm8jhTxjVEZ6H43i1/gQd?=
 =?us-ascii?Q?q3KuffVs1pkkiAkpXXVtFVUCvxRWI/WgNilEWmX+/KfZgQkj/HK3RYcvcLez?=
 =?us-ascii?Q?GPuQnnvJrnHqHGNL6yTaRhmedRE8yMLEbvmoowXkESe+sr7nYwSfUCyRuqC7?=
 =?us-ascii?Q?zdwTWQF1wqhRMLV74TjnMNkaUZjNAyQmuLFyA1nrW4deht4iygqNMFd09b9f?=
 =?us-ascii?Q?KWFxu6Am+oowoPznJAwWvuoy+XVswPlFPngC4LNDHgoqieN4EesBuYegyLgE?=
 =?us-ascii?Q?vnpkvgXoyV79+B8O4RFt6PNzxBF1UmKW8uX32T9x0L4qpKvu1SP5OXpzhWko?=
 =?us-ascii?Q?DB5+uL6BT/Z1I2mmXqIhA+xgzjAq6ddcoys5bLuttj+uPorwlfpRDvKEZM6M?=
 =?us-ascii?Q?Uow31tG7ZJU3MeHRq5tcvIFu+2ZMWEDyhhZRM+nktj+/narmXyAfeSEvQv+r?=
 =?us-ascii?Q?LLku4e0k9vekQfn8FQvh/9glqAgxa8iytumkkc23N2H4ZGdUWJEHnNug9KVg?=
 =?us-ascii?Q?nB128HwztAItfGZEhw7RlfeuE/CypD/wwz6/aFqmxt5+LSh0GBAnOCGvMGOM?=
 =?us-ascii?Q?6Fb/DqOKzSnjjUdCEaqzwIK0EIYtZXNVV/MBREGr+gqe/BME6RA+T/a/42K8?=
 =?us-ascii?Q?7z7pc5xSA1opVMvdNLRzpsevvLRO+UEM3BvAES6rWgTYRLbAu2V8PcGKDO0r?=
 =?us-ascii?Q?7jV5OTpCmX/ogqnou0w5uR0JbgvR76cqwf1VyxA38rf0WQed2Rjp4KTwfL5m?=
 =?us-ascii?Q?jfXwcssnktqCZiNAe3Nbh1wcseBVcZpMOZpuzEMY5KQpYVB4stjv26j59kiv?=
 =?us-ascii?Q?6hpcFSNpc1euooSB9sNZ/tKJ2nHT63UsVrBWC/yFomo1HeadCCiYXUMcughy?=
 =?us-ascii?Q?Dm5ENzqKE9QamE8M7XCeVqB+DCqbNQgEiXrfchjc/uTLxxNvsI2Kh7IB/qbl?=
 =?us-ascii?Q?kfdwhVM4ST1ZrJI0UIjqqpP4gC8zJ/btKVeEDlhxgi6Z+yQ4vL5oHXA06pNr?=
 =?us-ascii?Q?LEzDV6HtVlnyiDLizqxDgLI7UOPMyjAQt2dEa5T04s8jimOo/GiE1TjaboBB?=
 =?us-ascii?Q?m26gJ19PBNn5V1qMRMj/izbU+wTFz0tZeNUTaGQ631jGsL6S+iveVs20kGdW?=
 =?us-ascii?Q?1fA43QlJywc3xAkiMtppK3U6YKApMT/MQ4stXUioP161vEERafhYLxy3Ew3R?=
 =?us-ascii?Q?DjECO1j7YGPS1I/ozpmyf57Iz1abIHkkT/xS1Gva6xS+IDmLyN/Q5DuTRQ82?=
 =?us-ascii?Q?tODrnsU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A24B56FC7764394897A4C804346FCC97@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623ddd91-3250-4918-dfe7-08d91a998463
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:41:30.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hc3sW+QIOAsJ5w7RDb2iL5vbhkLGotOkezp/RMAdD20bGoviv8T0Fh1Z1+IpvYjznrQhsGXfcWiLPnU+Jl1iEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 4yrTwVtr-yiUt9QNv122v-bUggASKSrN
X-Proofpoint-GUID: 4yrTwVtr-yiUt9QNv122v-bUggASKSrN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_02:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=986
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190056
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 18, 2021, at 6:40 PM, Alexei Starovoitov <alexei.starovoitov@gmail=
.com> wrote:
>=20
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add BPF_PROG_RUN command as an alias to BPF_RPOG_TEST_RUN to better
> indicate the full range of use cases done by the command.
>=20
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

[...]=
