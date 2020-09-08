Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344B261E9B
	for <lists+bpf@lfdr.de>; Tue,  8 Sep 2020 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgIHTxA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Sep 2020 15:53:00 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730460AbgIHTwp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Sep 2020 15:52:45 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 088JlKtr010264;
        Tue, 8 Sep 2020 12:52:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+kciaNCu5WODnq+DiOC3i8Wscpe8OhfUlxlszxW0aNs=;
 b=osOmNmC58O6huVCDx+GbxVoKQj3vHgMnVQztd9mlE+3D9/MjrUmaCvvyvmfPFS6YP+Bs
 wCWxT6xywaNMoL9gPHhYwSSFtHIW/PGHC3llwpSjXQ+kndow+1KAaF9bvLnfkV/Ct00D
 FvmnqttQZGQrY+kqzB8X8iZwRhvbQdtZD8I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 33c91he7qb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Sep 2020 12:52:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Sep 2020 12:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtqG4WKWx2JzfVLeXGaPWWmHZb4PuZ6V0fa+zHckXpOonRHjbxHsMhMb1geC8LpHuNmzpYvW79ldiNVOLvxFjRarSxTbJbHhebCrS0IKYBJfKfJHUpwphw5r6HTmdctDnyLdbXn3LTXgJd8Drxwdap41KN47Hi1Rm3mGcKyNU8eEVO0BzpfK2xplItJ65U6lUtZq5jHPNH9y5069bM1qmb4hmu8EppbgMxMjcy/k8vUq08ULqEBLSAgKF+5jRsqIrlQGboDZeclybzOYpQUqIrruJKAWkoSmb2Mes+XsemjKIq8Ks/b3NUw3a8wDEMZprDi/UGQSHL2BuMqJQTHgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kciaNCu5WODnq+DiOC3i8Wscpe8OhfUlxlszxW0aNs=;
 b=YTKLjBd4nOIJ9cIm0pBL02FXFcQ3/6buqc9CZxBKuubSEQjFmS2cyxcL0sfSVhktg25vJEOo0NBSySNV9OdrDwKNeslJR3iwVAjauH5DjYhal/m7rFEy+lqOROqpePA42hJ4djLz7XITcADFsXHMEBjwuI3+n9RDXvJ49cSq4ZODTNOf2ISs2XiTEmD/THXm9jxtC+/V+7zHKensDSOKA/N26ABeMabfwp11TDQ1WAy1fmPHNzRDbj+Tuyp2F7PxBUnEqpa9KuO9TY/cpkeOM8RFfAm7EDESAukJVU3FQ9aT8SpHdNu39oywuw0gYr+e+cEB7n0glMAWUKyBmimd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kciaNCu5WODnq+DiOC3i8Wscpe8OhfUlxlszxW0aNs=;
 b=T1R0V1D0wQs3Cly2OujTSRcoBGMVAmvth2YYSVZvSX9soY9/SEis+rpvLpOUi66Vn8HCqqra1S2z2kRN+a06xynI5+gpEJe3xHncxSKeGehLVecKqdWJyH3sPfBccvQxIShBLFVCHfS8vVl4eOs+6geIesfrZW1wp+t1SPHaFuE=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2886.namprd15.prod.outlook.com (2603:10b6:a03:f7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 19:52:18 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 19:52:18 +0000
Date:   Tue, 8 Sep 2020 12:52:12 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as
 PTR_TO_SOCKET
Message-ID: <20200908195212.ekr3jn6ejnowhlz3@kafai-mbp>
References: <20200904095904.612390-1-lmb@cloudflare.com>
 <20200904095904.612390-2-lmb@cloudflare.com>
 <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
 <CACAyw9-ftMBnoqOt_0dhir+Y=2EW4iLsh=LYSH78hEF=STA1iw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw9-ftMBnoqOt_0dhir+Y=2EW4iLsh=LYSH78hEF=STA1iw@mail.gmail.com>
X-ClientProxiedBy: BY5PR17CA0036.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::49) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:b20e) by BY5PR17CA0036.namprd17.prod.outlook.com (2603:10b6:a03:1b8::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 19:52:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:b20e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c37ebaad-7659-4d07-aaae-08d85430b0d0
X-MS-TrafficTypeDiagnostic: BYAPR15MB2886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2886D865B626244D7001BCB8D5290@BYAPR15MB2886.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcCI8xInZvNs2YzP7zNRMFQ1xK0oGMrxoOpmqoCuBdoxgWx2sP3/nfjtLSKyWIQgDVB2slytdf1APutz9NvgTUY9n9dRPRXNT41UveNVKjFpi+Yyhi2aiP2cMZSsMRESjf3xN2AQVL6LMq+4MqVS7sYItx3/wirw0BYz8YchjLOHwWB9fNb/XqM+imTk174jtZEELk7oWmUVD9PRCZTg4nxvHcmkhxcyXG3jI/qxf1asOXl6yyXDJd/XqCszHeKKBoDWSONwRZSj3rsQMrtehvCcEtQOl/1McZcJagnPDFIDxuNlmHt2fjcfyHcB6LY5y4yVlupCX5SPApURB5VD+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39850400004)(366004)(376002)(16526019)(5660300002)(6666004)(186003)(55016002)(83380400001)(6916009)(4326008)(54906003)(316002)(9686003)(86362001)(8936002)(33716001)(52116002)(6496006)(8676002)(478600001)(66476007)(1076003)(66556008)(2906002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oPAiO4AzUvttmmoQjiOh1whE8gG9AUQcvoWDxH16juZKg6cMkfnadf+8F+TULAjpwzJF5ZLwSXeme1UCy1+D85HHMVRx7k3M79/3I8qFDdeo/uPWy4eeX3Ow/1T92ofHMPqMvdH09/dHuz6pDheWLS17EH81Of4V1XBmy0Pt73a5nE7MvjaW/R3IjZfj687vQX2LauD1PD/MX3uNePgaMRtNCnjEkV4vE014KHoXDOxQDaMZzElGpM7ASTn5c3ZpzV5i0FEYgZrutYl76nNxyDZEcTBQU/sFrYmodL+xUl1DmpdArVwiatuv9VhKUl7f/usNh1xBWuNKr52w51uULKGBdf467tPVMYxlX8pqKerpD4lK80xnnGOF3uW0/ybRIfDwVVm0ouADzk27MIFrosE+0KMyqLZQgbohzuZk6YccJUzRfd6w9Zro4hgXDBfVbWrddRLQGCKYBDxQdBsUdx2U9IM23hz+FqONLDKqKdj9tpDw8CUQCMrRxyFLHs5JgOkJdCs2UXwOFWpOc8giWw6CBU+ui+874WtBSw/pKs2e6RQdSAwg0aOrKYwqV6NXSOue6yhbsR7txjTs1zz58E0xxLNgq3VjITDHsuTiDqZ4wKDObHr7OISR9H7kLx/ZLO8wOWfff5CRHuf1fBK17gI8R2DA5BXMcTkO4rbQLHo=
X-MS-Exchange-CrossTenant-Network-Message-Id: c37ebaad-7659-4d07-aaae-08d85430b0d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 19:52:17.8831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TWJ1+QzrYToCSNn4R8gB7S9eT5g2ocKhfM3pGFIzXPWs8fG/wvl2cjYXSNoO6YR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2886
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_09:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080181
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 07, 2020 at 09:57:06AM +0100, Lorenz Bauer wrote:
> On Sun, 6 Sep 2020 at 23:40, Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Fri, Sep 04, 2020 at 10:58:59AM +0100, Lorenz Bauer wrote:
> > > Tracing programs can derive struct sock pointers from a variety
> > > of sources, e.g. a bpf_iter for sk_storage maps receives one as
> > > part of the context. It's desirable to be able to pass these to
> > > functions that expect PTR_TO_SOCKET. For example, it enables us
> > > to insert such a socket into a sockmap via map_elem_update.
> > >
> > > Teach the verifier that a PTR_TO_BTF_ID for a struct sock is
> > > equivalent to PTR_TO_SOCKET. There is one hazard here:
> > > bpf_sk_release also takes a PTR_TO_SOCKET, but expects it to be
> > > refcounted. Since this isn't the case for pointers derived from
> > > BTF we must prevent them from being passed to the function.
> > > Luckily, we can simply check that the ref_obj_id is not zero
> > > in release_reference, and return an error otherwise.
> > >
> > > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > > ---
> > >  kernel/bpf/verifier.c | 61 +++++++++++++++++++++++++------------------
> > >  1 file changed, 36 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index b4e9c56b8b32..509754c3aa7d 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -3908,6 +3908,9 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
> > >       return 0;
> > >  }
> > >
> > > +BTF_ID_LIST(btf_fullsock_ids)
> > > +BTF_ID(struct, sock)
> > It may be fine for the sockmap iter case to treat the "struct sock" BTF_ID
> > as a fullsock (i.e. PTR_TO_SOCKET).
> 
> I think it's unsafe even for the sockmap iter. Since it's a tracing
> prog there might
> be other ways for it to obtain a struct sock * in the future.
> 
> > This is a generic verifier change though.  For tracing, it is not always the
> > case.  It cannot always assume that the "struct sock *" in the function being
> > traced is always a fullsock.
> 
> Yes, I see, thanks for reminding me. What a footgun. I think the
> problem boils down
> to the fact that we can't express "this is a full socket" in BTF,
> since there is no such
> type in the kernel.
> 
> Which makes me wonder: how do tracing programs deal with struct sock*
> that really
> is a request sock or something?
PTR_TO_BTF_ID is handled differently, by BPF_PROBE_MEM, to take care
of cases like this.  bpf_jit_comp.c has some more details.

[ ... ]

> > > @@ -4561,6 +4569,9 @@ static int release_reference(struct bpf_verifier_env *env,
> > >       int err;
> > >       int i;
> > >
> > > +     if (!ref_obj_id)
> > > +             return -EINVAL;
> > hmm...... Is it sure this is needed?  If it was, it seems there was
> > an existing bug in release_reference_state() below which could not catch
> > the case where "bpf_sk_release()" is called on a pointer that has no
> > reference acquired before.
> 
> Since sk_release takes a PTR_TO_SOCKET, it's possible to pass a tracing
> struct sock * to it after this patch. Adding this check prevents the
> release from
> succeeding.
Not all existing PTR_TO_SOCK_COMMON takes a reference also.
Does it mean all these existing cases are broken?
For example, bpf_sk_release(__sk_buff->sk) is allowed now?

> 
> >
> > Can you write a verifier test to demonstrate the issue?
> 
> There is a selftest in this series that ensures calling sk_release
> doesn't work, which exercises this.b
I am not sure what Patch 4 of this series is testing.
bpf_sk_release is not even available in bpf tracing iter program.

There are ref tracking tests in tools/testing/selftests/bpf/verifier/ref_tracking.c.
Please add all ref count related test there to catch the issue.
