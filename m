Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE2553F89
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 02:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355409AbiFVAaO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 20:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355393AbiFVAaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 20:30:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20872F64A
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 17:30:12 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LN9JFN016198;
        Tue, 21 Jun 2022 17:29:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=LlxMht+x7OZIulwQtn5TLeK5aUxk7ZwShiosbQFv5c4=;
 b=PDz6EPZYd86D6PJCsQNkXi682Q9WQ2I8LgK12elyHQf50o5tATswK5F2GvrCiLkoiA8t
 lZk5kfgHl11pqz/CbSeqqyjDdf2AANIgq2PW8SfMriB1oJ030GRYJe78rZ8/38LK7hHG
 6Ei/cUxhHKKSDtJOWxICbt+a8W+RNzA9+BQ= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gukcga4cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 17:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsjJdqWUWNsHFQizeF/eySDDsye1JPF97+K+RzsYZcvO9aKHfHB0GXOZ2eBH9Ay16WDlovhzgvKOnd+rDf41hNdZn3JsmdzHsIIli+5q97+4rit3pnP9PZdTgrVL283W5zcnLVobOXoOPk8Mvvg89soU2oQnb8uBD8y6KDGIeWFCDlJXuvDy3qIhC1ADYCpUB9fxG9e9Cg3pNjmCYYXijr/qyMpN0ygXTtovvscHpnQM4Iju32Kdz6IUTKajNFoIA3uTV0cPwOiEtnn0tOLXHGWmoMU/Q325mPnm7ks3Su7eEU5+nbUfwD+lPHUZouyWmW1J2HN//q7W/DMkhgmKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf79d0o3pxkBtHghPc6Q/m65uZLWM0QtQN1Ffk8EG+4=;
 b=LuPfllMF+RctIIH7HLhmuZTwgfkH0dWirKRXtwEGoG6evpulxrWa/8dlUjrH6lPzQqJaiegMJ57yAt+UuoEUvyngeTb4E5Kg5PYNCSty64ufyWNam+73CBx5lkWDbj6ZWzwlR2hoL/J0xKQs+yCtOoiN+rHoDu2qvVrSSBZuOJ33YgbvpUe5dL/pWjhs8mPzrDnqevbBYHT4JVEsHh9qg3x1GGzBodH1ZLO9ly2+b57WmG0C9T7IDtf0+UvmT630H1g2LyGA81BWIa1GIBJemUD8ddo+NQ86jT+rNduxQOSwWk1nYvVTilt8dQ0ldbHVs73zrWLt2wN+6ic0FF+YuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4904.namprd15.prod.outlook.com (2603:10b6:806:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 00:29:55 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 00:29:55 +0000
Date:   Tue, 21 Jun 2022 17:29:52 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Message-ID: <20220622002952.6334ieb3kfysx7vl@kafai-mbp>
References: <20220620222554.270578-1-davemarchevsky@fb.com>
 <62b21962dc64_1627420844@john.notmuch>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62b21962dc64_1627420844@john.notmuch>
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a06074-7ba1-4867-c9ca-08da53e65482
X-MS-TrafficTypeDiagnostic: SA1PR15MB4904:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB49045A76195B2C8075190701D5B29@SA1PR15MB4904.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6W7cZa0uN2GPEwsEg+OGpLPhsTr7HXlve3j1E5YkqhJxU5G7MU5wAMO4anSfno+mMOoGKxY5ERVFcj3oOgtpj6GlA67mNkayhbQbZzLEqHaFDWAmK/vripfDkwwlpo9Ua709gIPKjCJBmTQHcLHDHehtazyWUULR5dua4S/7tQVnZZOOOZdi7BSg+HOOptfVO64aw6K9nJAmzJym1tKEUfQYTXriuVTeyLOIRux9YNX77hq18kCcdKG888/Et08prVJfUk44ae4t1sXBIVsx0sTIG5bJz7pw+u5lORxVTlVQOqgb4nSl90stn2NPzmxpxqU82/gHyM+lqxV85X6NDZ1ifdMa/MyK10x6nabMdLZIM0DfKDZszAFrEM20TLyB5GteCIzQInTy8PTog0qOspV8M+hhW3q9P3NWU6r4d0Dt/v83lx94N7nzlUhnv9FJxhZsmVM6Xd/i+hHugQRHuox4lMHFx4MOD4Yrjvy0v3j7CT5Gsuqb8EEShtCt+MSucsEgondfR8JwxPtolm8FPtomcUVdCdI8p9gMHWICKR2ASzefhTnPS1x/QK+UUKY3eEMTnSJlUAcB8aUO60pdSZuZwYuGr7fgDxLqbJ5FmPU+S4TBKnIEFqZGatpZn6nl9KzUwI3r6Ri0+8SocC79tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(2906002)(6666004)(54906003)(6512007)(9686003)(1076003)(86362001)(5660300002)(186003)(478600001)(8936002)(6486002)(52116002)(6916009)(38100700002)(41300700001)(66946007)(8676002)(66556008)(4326008)(66476007)(6506007)(316002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ts5JuqjS6GY445RYiTbAjwEmlJuuqjnL8ivZ0+7EXqF0R+ioxOsx++RMtR?=
 =?iso-8859-1?Q?GyopFEOBhdzQKBOzAzd86w6yEjLe4V4yVOw8UoC2sMo2V+1H5B25jA93D4?=
 =?iso-8859-1?Q?DmqkyVPOU17h9pYwsejGbekvA79xaEWKLbMs2B6qBrlDBlbiPJPKD9qbUL?=
 =?iso-8859-1?Q?XojeEvPAC/77CHZ06A4Sis5Yr8ueOw22uGJlyKPmrBYfrF7EY5c5XkM6Sg?=
 =?iso-8859-1?Q?ffmA+YYd3EK4Hf4JLhNbilWVlG7ND3ImngXeI4YlRm3wGXybShi7gdGpw5?=
 =?iso-8859-1?Q?2MXFBn0ZYvyoSLw0h/KRq2oacBctf0aiZWuHLrbtAcX8pY+BrUqrqRWHDh?=
 =?iso-8859-1?Q?1VM9uA4h8tsTqVBpAq4brHM2HmW2QvV9n4Q4+oaA/2bXggBX3kGE9SyS44?=
 =?iso-8859-1?Q?LrqVIWEtTN0hXRX5pVThlYggjFil4RMEA+LXUCo7MNnxc7dJZrD1zNNCQW?=
 =?iso-8859-1?Q?jkIe+/Ch9dQhkR4Jev83HSTKLV0b51BN2BVM/jDz2LcBE5Q0XUQSS7mMvo?=
 =?iso-8859-1?Q?xaj6f1zdDke4ipsKFnF6kHvtMaamjjYuq0r/WRNVhPuFE6MaWU15z57o3E?=
 =?iso-8859-1?Q?oYGl9eyLPlFe4nXkmazmkeTP10/L8t+t6NKtxFtIQ34hxVUTjJ4G2uNzsD?=
 =?iso-8859-1?Q?1/Id8fCFaXR5BcLVcw1wMm38sq5O3sZ6OAbmoBu5oMS3WiSTK07sGCPIC9?=
 =?iso-8859-1?Q?F02hoQaI9LbK9arwI4lzEB5S/Xvi549ACIRZwhYGiWc15M9r/uixDeom15?=
 =?iso-8859-1?Q?XVUTFzOTweNGoly2hSirtTKoVuF0EZ9jLohav2gPpG7VUy+6EUNFtcyzHd?=
 =?iso-8859-1?Q?/sVgiG5yaMTsTU7aG5aYupMwbqRquVFnNIfAXuQg91lDY5Pttazes0K/9K?=
 =?iso-8859-1?Q?H7QTcCVPUGp6bgSEyhV6xow7xgxKqBRQZmLnCHZZoWh6NosmziN1DXXJJm?=
 =?iso-8859-1?Q?q/KkM63BeJBOl7hCFbI4F8IcJEC2dEkSe3221wuWeazk3I0uO7zeU3+b9Q?=
 =?iso-8859-1?Q?fnm7+kc6IvGOYFjNKVVM+qozwi/bPRlSRfQJFgBbr2alBZBAbfcA5BdUGM?=
 =?iso-8859-1?Q?3HqnIlvyLdhB1N1QWrwx8QPV6RXthYqn2qaJB5xZwu7eRehwkNDM/CbtLp?=
 =?iso-8859-1?Q?hNhRg0OP88iILlwFbKlWdBFCzbzOKVj+DV4Dhc0KtLQlQGd6aOK3Z9iugT?=
 =?iso-8859-1?Q?sEl+HRQT9sWWcM3v+uiWFZC+GvdiKpvmFcDjk3+LfQrjs+WkHN1WtU1+UY?=
 =?iso-8859-1?Q?71hlxaU7w/PisWEXP4a3FaBwewwF4TFt+MXSIgqYKaMp5Xij2t0vE6JopD?=
 =?iso-8859-1?Q?1WqMRebGXLzxBNqg9SYbi3iqFGnuywPd9LKLGRx1Pba1jT3cfu9y+CrY6J?=
 =?iso-8859-1?Q?+kKFFyPuLCk90mnzCaTQ2w0YtfETm9zIMRK8w/kbNLwJsog9332jnRHNzs?=
 =?iso-8859-1?Q?2PiylyBDgOOasFLaU545W7tKMhFvby1a6CX7fWNNXoHCvRWZ1DGX/WIeiq?=
 =?iso-8859-1?Q?/0lCtXCNw9ye9W+K/g5abW72YyZ3InVxdgn1aUgPMtU7AeaOu2xe4ktlPR?=
 =?iso-8859-1?Q?vVn0RNy5hmJbxy79ep0B6YqIxa9XdlDJ4yYQGxGqFAbT8fjiLdTUGICOk0?=
 =?iso-8859-1?Q?yLcpDD4pAStoMWIgyb4ju9LzkdMCy3YQ68D7N42U5e6YewF2ayddqeWG+D?=
 =?iso-8859-1?Q?d3WntpveSgw1+AhNhQ+lKdAckBKSdxbptq2cPY6r8xD4DEFGmtUBb0onxN?=
 =?iso-8859-1?Q?gtn3VrpvVX+b7zeQhPmugWKdl6h++pXE3jM5xjDtFhsSHTJwls3WfUJiCU?=
 =?iso-8859-1?Q?YxXWopM04xZIZYoN7sRjvlQpnOMkkBs=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a06074-7ba1-4867-c9ca-08da53e65482
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 00:29:55.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtXSqyOQtqGez8Nbjwm4CTAWWNqHJQN65UGjVI6f5TMXNuBZf0uVwn95Sx/+VzWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4904
X-Proofpoint-GUID: EExzyJ_VtGdntnpR1BULJwvFK2nsLdIb
X-Proofpoint-ORIG-GUID: EExzyJ_VtGdntnpR1BULJwvFK2nsLdIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 12:17:54PM -0700, John Fastabend wrote:
> > Hashmap Control
> > ===============
> >         num keys: 10
> > hashmap (control) sequential    get:  hits throughput: 20.900 ± 0.334 M ops/s, hits latency: 47.847 ns/op, important_hits throughput: 20.900 ± 0.334 M ops/s
> > 
> >         num keys: 1000
> > hashmap (control) sequential    get:  hits throughput: 13.758 ± 0.219 M ops/s, hits latency: 72.683 ns/op, important_hits throughput: 13.758 ± 0.219 M ops/s
> > 
> >         num keys: 10000
> > hashmap (control) sequential    get:  hits throughput: 6.995 ± 0.034 M ops/s, hits latency: 142.959 ns/op, important_hits throughput: 6.995 ± 0.034 M ops/s
> > 
> >         num keys: 100000
> > hashmap (control) sequential    get:  hits throughput: 4.452 ± 0.371 M ops/s, hits latency: 224.635 ns/op, important_hits throughput: 4.452 ± 0.371 M ops/s
> > 
> >         num keys: 4194304
> > hashmap (control) sequential    get:  hits throughput: 3.043 ± 0.033 M ops/s, hits latency: 328.587 ns/op, important_hits throughput: 3.043 ± 0.033 M ops/s
> > 
> 
> Why is the hashmap lookup not constant with the number of keys? It looks
> like its prepopulated without collisions so I wouldn't expect any
> extra ops on the lookup side after looking at the code quickly.
It may be due to the cpu-cache misses as the map grows.
