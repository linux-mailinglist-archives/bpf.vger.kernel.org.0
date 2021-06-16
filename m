Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2559F3A96A3
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 11:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhFPJ42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 05:56:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16500 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231389AbhFPJ42 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Jun 2021 05:56:28 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G9io5Y025070;
        Wed, 16 Jun 2021 02:54:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sLmUctw2GzcH7hcFAvljfwrZJ2Zn5yu86O0mhyWMpgA=;
 b=lPrBBDV9gwUF4bWD0lgk+0/zC/KdtQC20sN3+ZnqFvNYqllzkrARvYwnT6DyriuTIYSP
 hRvRfpAlDSuBCqFkN2RS38FwPAxL8zWypI1pWQ6CobmF9j+qAB+e4Jtt9OMahanQiZLC
 VufNjedksePYLNaQb7MaBDkEeh878h9kHe8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 396fy4hp50-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 02:54:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 02:54:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqDaD7jpbwaZPF2R7P1kayHA4ZG3+7jvZK1suCVLFLzwI6KSPjXFqasy+Da00pECocme+a1r1BuHBZtAXiaBv5IYpa+/TbTIiLzlYz2/jU5cVlIXFEUCZXb7aBTYyl3xGp7q+9WG4dz2pvv4ORRkP9bsrF62CWMAk0cqENQKecMlvdhBu50uSENzoGcMIvq2tA8yBsHmJk5Zh0RFWNxwM9LRVErzNbzQYo2Y/PPtso957Ko/nh64+2cEh9aq0SygUZVNoovsLCtM5yUdwJ0nscOAfb7BpgQb6/3ltmaLNiody80kMvK5UDuJIT7uJnX5nQ2fEDFzWIHTKpO6eD0BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMLsgNv8SJxx5XSsCs4McKrDJI6yLKRTf6AJxe2ZIio=;
 b=Q1sQHsNOuXxbv2wxiLOMcuJdiWhFPqF5Rhxroj/bItW0zkn9fjo8SQXdkBjYWPYzq9rfaL27nX13R9TkLldbv44aosEw2UDEeox5YWa6p/IrV96X64Oo44oyAb+uOBotRCphOnGNYnH/ty6zXBLs6oy8HtBsfM7nkzZN/1M22wANLJ0uAisqTDUtjNd7KuA2JjK+tXcajCxAVmnBRpAwT8iHqbfTKeBPdXuNo7DjKo5eeTjVKiuBEwHTdAQRkWq8FWaIhSInZ4jhiotsr0dDzzbgURhxWmdWpcy2bf9K7sTse2PiSVXB3IQD6tCtksf4JCD3j6eyRc80R8tgvhktog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from PH0PR15MB4784.namprd15.prod.outlook.com (2603:10b6:510:8d::17)
 by PH0PR15MB4912.namprd15.prod.outlook.com (2603:10b6:510:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Wed, 16 Jun
 2021 09:54:17 +0000
Received: from PH0PR15MB4784.namprd15.prod.outlook.com
 ([fe80::4f6:97d4:ec70:461c]) by PH0PR15MB4784.namprd15.prod.outlook.com
 ([fe80::4f6:97d4:ec70:461c%7]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 09:54:17 +0000
From:   Blaise Sanouillet <blez@fb.com>
To:     carlos antonio neira bustos <cneirabustos@gmail.com>,
        Yonghong Song <yhs@fb.com>
CC:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
Thread-Topic: Extending bpf_get_ns_current_pid_tgid()
Thread-Index: AQHWuUbDherKhQaNQEqJohDrmteEb6nFNNsAgAAIYACAADbcgIAAZ4vDgABGAoCAACh8gIFQ26aAgACRK1Y=
Date:   Wed, 16 Jun 2021 09:54:17 +0000
Message-ID: <PH0PR15MB478411846A2DE571D6B62158A00F9@PH0PR15MB4784.namprd15.prod.outlook.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
 <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
 <9067600b-f340-ec3e-2ce8-d299793c123a@fb.com>,<CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
In-Reply-To: <CACiB22iU3zk4Row=wAween=rSvHJ7j7M5T2KbyFk38arzEwQpQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c092:400::4:b1a1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ff2a662-6bfe-4e0b-2a9f-08d930acb4a2
x-ms-traffictypediagnostic: PH0PR15MB4912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR15MB49123168B24126CF0E7021E5A00F9@PH0PR15MB4912.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: emlnLYBzwjlYvLIJN40zA29rbtJsrm/ORsEYVzkCECTSkWb3OsnrF/L6mr5cPAXFOfMT+MDqlSfg/LsgX/S1igCYZXC7JVFd66Vph4Y1SziAwfcuUPnwjTF8Z+ZAEI+7sDD0RSjO2UZZNNQdJOyOdwWilRye3yJFzcxNTRRUl7K5CqRMpcvO+d8k6+hJwX0yL8gJPJe/0vaiK5nS9ezjwIXqo0OS6unH8afH9eYNtdtVy5dmOKhvYfvu2meH7OCVVxf2fU5L7ugx9q4Z0EAcGsUxXI/xNp+K50emk1zpqB3IIhvo5J2hpdknfjIBLvv+J4xaJTDQllCSPnVeGUt/izrfxqpAlwJSQtdKDvDZmUxj0R5qI2sYotb3HM+Seb7ebLXqXlZPOQ7CpIJ9ubJSUyCpL+sMG0SoL8Q33zhjGqduAoToZm10ESkLj9DRIbWN5OoSQIReN9B+G8QTWhXOPJ8s9tkRx4DgobWev0OwbpyeO2uAHszzL2P/7dtRDylZ5PLXKqZwbS7cmuG9hLR5SCNvg7NmEn+KZ/fjTS2rRwHkSyYTJFAtSol5TeHKKDwNP+z8O4fVA/R1MY/adxM6RJsPyhAs/V66DAYc2Kj+KjwkESl/ve5fxduQld9YxVE6JCFjI7B1CobdgwJ3Z+/h7TstFhcPcHJcc997V8xmP5sf0DGohhCYrtcA3BLnth6vWArXw4oJVkOrKFTEpWKT/NJgkE3EHqcdZj9gpMi3gvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB4784.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(54906003)(110136005)(52536014)(5660300002)(6506007)(7696005)(33656002)(91956017)(53546011)(966005)(316002)(66946007)(66446008)(66476007)(64756008)(66556008)(76116006)(7116003)(8936002)(478600001)(8676002)(6636002)(4326008)(86362001)(9686003)(2906002)(55016002)(71200400001)(186003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I1Xrj79J3NUCW0Uij/B1ZY8Wfhiusca3WrLxe8jGgiPBd64cgik7MqHhXG?=
 =?iso-8859-1?Q?Pai/TvMB0AhrBeH4gypIPiU1jSBOZylRB3XXHrSNfBMLDhupaDNCd5P939?=
 =?iso-8859-1?Q?Q0wM96RKKsymW96YQHICBLCbhFvFqwX7QTm9hVBLEZ9j+N89pYswafgwsR?=
 =?iso-8859-1?Q?hnqoHcaE8rjriNbfI4AXup4vaf/HsWm/LMIoCnstiuHUjE3n2EKc0EloFA?=
 =?iso-8859-1?Q?jHkI1127arULz+IDl+nLj38w+xlpFSLPb46fZaG4uID9JMbXilCrirN4+W?=
 =?iso-8859-1?Q?2dLu+ainHybs+kuJqTKDkl1ahhg5qcLQjJZ4EfBTcrs4oEgJcFgt0ER8z4?=
 =?iso-8859-1?Q?k+MDqUfstxNvc0Kelh1ZBjpbNnQuMtWC5uXk6UMTAeDYG569Tlda0Mq7tk?=
 =?iso-8859-1?Q?PICx3M1Ra6WPei0OIyW/TOfb5ysgufAfFSrJIyhev+vXpeNzID8cQXCCuj?=
 =?iso-8859-1?Q?iP4udpsd9m+uIP+ZCDZXZG42N8I9JstUrUpYU1aEKLYkVl0b0em//EYVeW?=
 =?iso-8859-1?Q?AsIA17D3dNb0SQCgshzufQESoAaxdLopnNku78HqmLgirmo8UiSHIVlNDp?=
 =?iso-8859-1?Q?EL716/tEmqgK2N4+HFVRn4/QPfKbIc5+VBFvLIfAuVLW6ktmv9mm5UJ8aB?=
 =?iso-8859-1?Q?etMCRMxu29eVCYvELLbqGNOGGQ3Tg14qqqBL4WluyvTCEnjLnsCZefqum/?=
 =?iso-8859-1?Q?b1VWdQ1AagJQfo2PqtQy6K9g+kkDpbBFkWzizvM4KuLiLSg6OLzx9uz58c?=
 =?iso-8859-1?Q?SCDJEhE2hNICKjQR83MsC/gHnBGH2lCqCTroyUW77ptLpevlyEeyomKWLj?=
 =?iso-8859-1?Q?/oK2MC3VcfaA3CHFJZn6qQE/hhuGFmzRrsPo1j2i+QWqUJufCFzZT202Nf?=
 =?iso-8859-1?Q?oybUUN+zmCxv0/QEaj+7sbb9X8iq2nQdcKVwDR50p4/eOD51hrPPUe42re?=
 =?iso-8859-1?Q?exyQ6fwLIavVzvWffihrKFbvy6FPzJgAk5ZTp2IqsVtVVX+aAMMb+0Jw1h?=
 =?iso-8859-1?Q?ix8mWmlG475TsY8dF6iGnTnpa/e+4FrnacKl35mvBhwBmXgRkKJ6k6+W5Z?=
 =?iso-8859-1?Q?g42ZIkhyNIcXpMR9tJH4qcZtyfLgyka04A9YAnvHy3xHQrLNPC11nDHP2U?=
 =?iso-8859-1?Q?b/K7LT8KcxZ3ky286a7MC1Gy19xuc1mBOhf+lNosVqI1Ga3BVCflLqtlM9?=
 =?iso-8859-1?Q?Y6HfmGr2ZFEFc3WDyACjHhjvVAmbSFuyv59BpSdj8yHC+zT/51Qg7zmolF?=
 =?iso-8859-1?Q?QiCko3Xq7BEA45nb/wB2R+n2sZC7+vDQnNUQki8f3Rt1fVaIoJejxjl6T6?=
 =?iso-8859-1?Q?M8xqLeM/7bxtEr4P7L6pbkQtDvAT95+Ms9I+8U+Obme6ZySNG1lJ3B5/m8?=
 =?iso-8859-1?Q?Ms1zVAFBoBemY0V7PTEXX0O+a5ORFe8w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4784.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff2a662-6bfe-4e0b-2a9f-08d930acb4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 09:54:17.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EoP+a334DGbkTIl/YHH4Xn0cqntKWxtomBImjoRHGvj1P/dYrA0oFOhrCbvQXnY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4912
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: i-_u3f9VV4APq6vmlmplMEqv2IAbIyhK
X-Proofpoint-GUID: i-_u3f9VV4APq6vmlmplMEqv2IAbIyhK
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160056
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> I'm resuming work on this and would like to know your opinion and concern=
s about the following proposal:

Thank you so much for doing this!

> - Add=A0 s_dev from=A0 nsfs to ns_common, so now ns_common will have inod=
e and
> device to identify the namespace, as in the future namespaces will need t=
o match against ino and device.
>=20
> - That will allow us to remove the call to ns_match on because the values
> checked are now present in ns_common (ino and dev_t).
>=20
> - Add a new helper named=A0 bpf_get_current_pid_tgid_from_ns that will re=
turn
> pid/tgid from the current task if pid ns matches ino and dev supplied by =
the=20
> user as now both values are in ns_common.

Maybe that's what you meant but I would express it this way:
  return pid/tgid from the current task as observed from the pid namespace
  matching ino/dev, or return error if the task is outside that pid namespa=
ce or
  its descendants (i.e. the pid namespace matching ino/dev can't see the ta=
sk).

Thanks,
Blaise

On Fri, Nov 13, 2020 at 1:59 PM Yonghong Song <yhs@fb.com> wrote:


On 11/13/20 6:34 AM, carlos antonio neira bustos wrote:
> Hi Blaise and Daniel,
>=20
>=20
> I was following a couple of months ago how bpftrace was going to handle=20
> this situation. I thought this PR=20
> https://github.com/iovisor/bpftrace/pull/1602=20
> <https://github.com/iovisor/bpftrace/pull/1602>=A0was going to be merged=
=20
> but just found today that is not working.
>=20
> I agree with Yonghong Song on the approach of using the two helpers=20
> (bpf_get_pid_tgid() and bpf_get_ns_current_pid_tgid()) to move forward=20
> on the short term,=A0bpf_get_ns_current_pid_tgid works as a replacement=
=A0=20
> to bpf_get_pid_tgid when you are instrumenting inside a container.
>=20
> But the use case described by Blaise is one I would like to use bpftrace,
>=20
> If nobody is against it, I=A0could start working on a new helper to=20
> address that situation as I need to have bpftrace working in that scenari=
o.

Yes, please. Thanks!

>=20
> For my understanding of the problem the new helper should be able to=20
> return pid/tgid from a target namespace, is that correct?.

Yes. This way, the stack trace can correlate to target namespace for
symbolization purpose.

>=20
>=20
> Bests
>=20
>=20
[...]=
