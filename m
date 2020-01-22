Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80486145B6E
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgAVSSl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 13:18:41 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgAVSSl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 13:18:41 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MI542S030625;
        Wed, 22 Jan 2020 10:18:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lwdgi7JW29+K1kYrRvzCGTzCLGV3L62toUfWrZeiuv8=;
 b=Jk8qKAdAK7YqCIVB7JSHdaS+gfbD44sgnRGPKHCU39MmVjhjn+TM3McSzerW9JVAuRN0
 o2Bw7SKjbvaa/qNnhICKhLVgY6kagdMs2HoDqNQwsnoaPSFUrAlg9WSeBJz0rvsOW20B
 XyTWUYR6yW90Xc8l2XEPwJ3WXhk6sH5rlDw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xpu2105qw-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Jan 2020 10:18:39 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Jan 2020 10:18:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FokgN9AUjjw/dkX/OKaUMXcNrXBFnjHRBGka/lTGaojS6cM1dMOR5lZBe87qfm9RMqHnHBinOxogEBl/+KHXS10dFlTON3b1v8EZ/5Ou0WQlHkozWuGMlqo5Urn2kJtGsKACVjfcrmqK8uScxpvGgSmxreaK1fvfhlaRQmhHq54rJx9vKnDS0zJgEtg+pMLpNaHEOFikPajHb0+moqjDgKlItG5r/V9puMwRlpI9XR8CL1QSN5/U2k6AgpMqchxYySdIRzO6x1/ZjJJoG9H6Ycl3p6S5jMMrZ7/Mx6Tn2cWvdDjUreDOCQKJMOhVlomkQTuC3QTKFOYyhopKmXdUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwdgi7JW29+K1kYrRvzCGTzCLGV3L62toUfWrZeiuv8=;
 b=Nba+ECzTG2r7lqJa87ScnnwC+7NpjJcPSoPo826mc53/ErtN12zjxDRWz3GoCYvWEOTo6jiBYEjBNaWIQSm736EIJi6Dcm1qEsJnsNcDSuza2QPNpr2L05OalxZLvpDGU9blbP1XtzqbijzSiDmOIgHxLASivPPl0wMDiKj8dVl+tTB6YTMKGgAAmKjRQg/MtfjBEerDjbtHiNS8dpUQOlwPaYGU4LfVH/6IWCfOMflXomvOuYXZtD5cZACApCRp8LKCwe4kmLHcAI67z9yYHXTx+p+N5xs6Xy0gJIxrdXbOVMaqeEiGdvToQ2cYmB/K56Y2O0nuaHC6zpnF845cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwdgi7JW29+K1kYrRvzCGTzCLGV3L62toUfWrZeiuv8=;
 b=Sq9QzgDXF/MmUaZ3ah3QXWK986Mgn0OpUbw4tbzGSrFK+J9SKnWJTTC1kUGX5r1SKfKKUzODCSTPz/h1UlffeL+ImfzyJYdNYG8nq44sW/sXTf/Apjp1LeVX/TEHG2RkFLqriM5Qv6SiiId2p6xZNDwFyP69Klu7KIlYcO9dHXY=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB3360.namprd15.prod.outlook.com (20.179.20.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 18:18:09 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 18:18:09 +0000
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:180::ccdf) by MWHPR1401CA0021.namprd14.prod.outlook.com (2603:10b6:301:4b::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 18:18:08 +0000
From:   Martin Lau <kafai@fb.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: [LSF/MM/BPF TOPIC] BPF TCP-CC and more
Thread-Topic: [LSF/MM/BPF TOPIC] BPF TCP-CC and more
Thread-Index: AQHV0VBMXQ46YC6DpUm3/nB+F8xjag==
Date:   Wed, 22 Jan 2020 18:18:09 +0000
Message-ID: <20200122181804.sy4o3eihn274u46a@kafai-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0021.namprd14.prod.outlook.com
 (2603:10b6:301:4b::31) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::ccdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af49ae69-4f5a-4585-55ba-08d79f676f2f
x-ms-traffictypediagnostic: MN2PR15MB3360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB33606EB7F97A5ADCFA446117D50C0@MN2PR15MB3360.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(189003)(199004)(7696005)(52116002)(71200400001)(478600001)(6506007)(5660300002)(66476007)(66946007)(54906003)(4326008)(1076003)(16526019)(186003)(9686003)(55016002)(81166006)(66446008)(64756008)(81156014)(2906002)(6916009)(86362001)(66556008)(8936002)(8676002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB3360;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wklrks/fs+mVkADBtyfK3hWDIYgRnOUotMlolno644pcMTKPH+h5rprqw/cVF3NGhWAF9bXxFYo5n6Fk9IrLCdfeDdBJoG+Xfk22qcBYLJQuPFd09kLArY5ANfmP2JTd2rd77EOPQS7IWFsbPP7BjmHLfH430z8SoTrBe2Q8y3iPFTsuNfV/Twxg26xpYFscasYdovohjfOolp+uekVQm9hiT2mR7BxHh2i13mVjzInGkibzEZx/Hx9Z3VN9zGByugCXyMqbO8A5/T9+D/NrjbJ0+o1nYWFhUtjjlDAuDZ03DqK3GrQgA16bd5wXe52/7NqR47REDZ0+aNgSVnSmrFb/ZiUHZ5gYnENBK4t0zZ/u+qtxGCaY3Z56MRlwpk3I+vNfOEh+Qggc0pmTPVT4/ika1gOxxiyKIfxtdR1wXSY0vdnZuBuqXMdzFGAI2e40
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1F54C390DD8584D80E6C33EBBDD1389@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af49ae69-4f5a-4585-55ba-08d79f676f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 18:18:09.4564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFqueTO5Xb/zMW/MGBRVZ5zfD38ZPZkYa+fcjvJf7p8cssteYiSwvA9C2d9Cvjpi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-22_08:2020-01-22,2020-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=1 bulkscore=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=1 lowpriorityscore=0
 mlxlogscore=196 phishscore=0 malwarescore=0 clxscore=1011 mlxscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220154
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* BPF TCP-CC and more

There is a constant need to change the network protocol (and its underlying
algorithm) to make improvements.  Protocol ossification is one of the
well-understood production hurdles.

Even within a well-self-contained network environment like data-center,
it is challenging to rollout out this kind of changes while a long tail of
kernel version running.  Also, another question is how to enable different
expertise (e.g. TCP Congestion Control expert) to implement kernel changes
easier and safer.  The above essentially limited the speed of implementing
and rolling out network-protocol related kernel changes.  BPF has become a
natural solution for these.

This talk will first discuss about BPF STRUCT_OPS which was first
introduced to allow writing TCP CC in BPF.  What has been done
and which parts still need some works.

Another discussion of this topic is about what other parts of the network
protocol could be made extensible by BPF.  For example, one idea is
to make TCP header options extensible by BPF.
