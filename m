Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9D2147959
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 09:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgAXIZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 03:25:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgAXIZt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 03:25:49 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00O8OvpN029564;
        Fri, 24 Jan 2020 00:25:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ROWFH0vDTs8AVIwXhJvpa4E2L+tpBjwYMl2iwJCe/Pw=;
 b=iBfNTXsUTsXYz+VDIunA5rT3Uf2ZB+JnaqOkWttZ9UsJ/JqovQy1Tq4z5UO7NuKkZdaS
 7wp00n5roVChT5e+6HDSS+AW0BJMZjgu98uLBnHAXY+NzxtjpwvFNkOmfDONw7YEc0kt
 +nwf5DQxlVnPBqPx4lwAiD+2XFsYDJSyxuQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xpxanf8xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jan 2020 00:25:24 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 00:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLZLjK2x77hOoOwkinM/Mj+dUfKTHBNZo0/PKlJf0iqpRc97tZjaSONFe4GcDn7P7cI+DGm+9UfcK4GHkAJoTcOhJTkz1QSuDY9zIifxR2ZwLCRlnlVXO12K8xfUf5hz6Ka7EkFA9myzMXngvd/MQmkjwHXA7myJxFjYc/gb/Ud0+oSTJ6GelrPsWyesyK0fcUMIUK3b2xO840JItev8MLWOZGfyyclay4JpmafuJSHCW/zFhNAeoyFg1LHnDzCr+be5uN3ShYg/UQDIBlETv5mrfuxq2tMTmYukhjQB+IUpZFSfOByIREkEVgrO/1cSbbwC+f/HKmsHnCofWBlPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROWFH0vDTs8AVIwXhJvpa4E2L+tpBjwYMl2iwJCe/Pw=;
 b=nj3gvumplGl+TH+Y9IpdkbbN3hnAF23Rnb4QUbj+LltyZLIB2tkxvsJueN4iDR8EHXoGJ0lLL+i78iP+wWozJUncgAj2185AY9prVINyFEorCM0/pJZqoSWvzFYcvkrX4pchVuyyvvFlEpjdntEpS6MY9gD7IjnBXbrlVU7p/BoVLhm9qpl4kgtPzTv2jepVxrhyPnQJO2Dwp71B/dDJN2qU0ESAo1ffLFvHNPolDfilrrRKuIJk/RRrBH7G9HDDFglhmH6cZnzeqcXTjvW7qmii5TgQHFAv1dlfNjoU0OXuI676Uk3T1lUOZ7AjQqsi5gy0JEyiwvr7boSNRmoJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROWFH0vDTs8AVIwXhJvpa4E2L+tpBjwYMl2iwJCe/Pw=;
 b=AtrbBQ9QcALcMa0a/Fas+d3J8zvqqMNk8UaWnGhseZAH010qnXZFedHe46WaMs2SKMS9N5APuQ6fyFRvQ1Ni6R/k+slX//WguvZN99MxtIywCyJwIPn7e+5wepqOmC9VP5uzKlEIQuOot0s0VKYbl4OHuiMSG24DEAvFGwyXOCg=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB3598.namprd15.prod.outlook.com (52.132.175.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.19; Fri, 24 Jan 2020 08:25:07 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 08:25:07 +0000
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:180::d6ea) by MWHPR02CA0005.namprd02.prod.outlook.com (2603:10b6:300:4b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Fri, 24 Jan 2020 08:25:04 +0000
From:   Martin Lau <kafai@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     John Fastabend <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Topic: [PATCH v3 bpf-next 1/3] bpf: Add bpf_perf_prog_read_branches()
 helper
Thread-Index: AQHV0jNkMKZbcmePk06Qcg6q4FDVe6f4+78AgAAUpgCAAGq+gA==
Date:   Fri, 24 Jan 2020 08:25:06 +0000
Message-ID: <20200124082501.2uw6rqhou4wc27ht@kafai-mbp.dhcp.thefacebook.com>
References: <5e2a3f00a996a_7f9e2ab8c3f9e5c4a6@john-XPS-13-9370.notmuch>
 <C03NHG5CJ6QU.2ZCQR4TKW3ZWN@dlxu-fedora-R90QNFJV>
In-Reply-To: <C03NHG5CJ6QU.2ZCQR4TKW3ZWN@dlxu-fedora-R90QNFJV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:300:4b::15) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::d6ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f659c80b-df4e-4feb-3bd1-08d7a0a6ead2
x-ms-traffictypediagnostic: MN2PR15MB3598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB35980CDA9F47C974121D44DDD50E0@MN2PR15MB3598.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(54906003)(7696005)(8676002)(52116002)(2906002)(1076003)(316002)(81156014)(8936002)(478600001)(86362001)(81166006)(6506007)(4326008)(16526019)(186003)(5660300002)(66446008)(6916009)(71200400001)(64756008)(66556008)(66476007)(9686003)(55016002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB3598;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++hXmYCJUpQGAsHSintS4+ys2wi0SRxgeHi8ZDXMJ1oSHDdgHJtu3lqSQFeGMtSenDLNRCmyuINZgqpwYqBsI1uQiUSHTrhdrQD3DD8aT7VnguVTSbakhBLictdymomZUW4ThopA0TklGRGn/oqiHQ0fyG4/WWWRk9CZB2A1mPj5cOxnn/9Bpxn3/wLGueEy29GF5kr65JUJM33jay9aQk6Lj2g2JVZ2EyLEBPzrhoz8tlMdSKyCB9q/HKYgJlCFo6tChDAMav/5HdVO5qsPfR6sLw4jdCoII3fkhwDa7dGl7+efN4btQPyBREX4Dr+YDJRouM0hp1oX45/PhKG467Mj5exx290M7p8raRIGFocFpZu0nfGsdTmnfB3zoXL61+DxyXNHRHinix8K59IKobR8qMtQm97d9ZzdVtMqMvtGrEYZ1sUnKm5w1nYJWA44
x-ms-exchange-antispam-messagedata: /Zp0msnvprW0NXX3RvZ1euvw8k7ppJE2RKNNeccbdGDy9ORQvAKti8F5mH5XTTgPEiS+QbVmf9y3W9AWrtDjqxylkxBGWOHtkAp1wGTJS/Ore4WLilVj6QYN5TlZfcBltO1EbkAqzE4SLQPw8sVfcUh00beB/v4AccsJx6Sb2pA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C1E0A7B571128A47A327E3CBBA4B7B6D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f659c80b-df4e-4feb-3bd1-08d7a0a6ead2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 08:25:06.9911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBLU+g1VWtiImNbzx3fM8ySFf632139kYYzYhflGJbnKuKiy5cRAbbCPFjk5Q0sm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3598
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_02:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001240069
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 23, 2020 at 06:02:58PM -0800, Daniel Xu wrote:
> On Thu Jan 23, 2020 at 4:49 PM, John Fastabend wrote:
> [...]
> > >   * function eBPF program intends to call
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 19e793aa441a..24c51272a1f7 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1028,6 +1028,35 @@ static const struct bpf_func_proto bpf_perf_pr=
og_read_value_proto =3D {
> > >           .arg3_type      =3D ARG_CONST_SIZE,
> > >  };
> > > =20
> > > +BPF_CALL_3(bpf_perf_prog_read_branches, struct bpf_perf_event_data_k=
ern *, ctx,
> > > +	   void *, buf, u32, size)
> > > +{
> > > +	struct perf_branch_stack *br_stack =3D ctx->data->br_stack;
> > > +	u32 to_copy =3D 0, to_clear =3D size;
> > > +	int err =3D -EINVAL;
> > > +
> > > +	if (unlikely(!br_stack))
> > > +		goto clear;
> > > +
> > > +	to_copy =3D min_t(u32, br_stack->nr * sizeof(struct perf_branch_ent=
ry), size);
> > > +	to_clear -=3D to_copy;
> > > +
> > > +	memcpy(buf, br_stack->entries, to_copy);
> > > +	err =3D to_copy;
> > > +clear:
> >
> >=20
> > There appears to be agreement to clear the extra buffer on error but
> > what about
> > in the non-error case? I expect one usage pattern is to submit a fairly
> > large
> > buffer, large enough to handle worse case nr, in this case we end up
> > zero'ing
> > memory even in the succesful case. Can we skip the clear in this case?
> > Maybe
> > its not too important either way but seems unnecessary.
After some thoughts,  I also think clearing for non-error case
is not ideal.  DanielXu, is it the common use case to always
have a large enough buf size to capture the interested data?

> >
> >=20
> > > +	memset(buf + to_copy, 0, to_clear);
> > > +	return err;
> > > +}
> >
>=20
> Given Yonghong's suggestion of a flag argument, we need to allow users
> to pass in a null ptr while getting buffer size. So I'll change the `buf`
> argument to be ARG_PTR_TO_MEM_OR_NULL, which requires the buffer be
> initialized. We can skip zero'ing out altogether.
>=20
> Although I think the end result is the same -- now the user has to zero i=
t
> out. Unfortunately ARG_PTR_TO_UNINITIALIZED_MEM_OR_NULL is not
> implemented yet.
A "flags" arg can be added but not used to keep our option open in the
future.  Not sure it has to be implemented now though.
I would think whether there is an immediate usecase to learn
br_stack->nr through an extra bpf helper call in every event.

When there is a use case for learning br_stack->nr,
there may have multiple ways to do it also,
this "flags" arg, or another helper,
or br_stack->nr may be read directly with the help of BTF.
