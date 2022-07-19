Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2E57A502
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbiGSRTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbiGSRT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:19:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FAB481DC;
        Tue, 19 Jul 2022 10:19:26 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDbKWj021732;
        Tue, 19 Jul 2022 10:19:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Oqzw423u3WoxACEKX5y6ghpnXDd7JdKRUwp2nLJhQRU=;
 b=QX6wC8nKVquFMe3o096A9ni4aXJMX8zEqB1sDlXwi4kbCJzX9Qvotr0MCsDJyliDaJW1
 Plla44eCGWPjCIm6HRXQyiWvSvSIu80kjsWxQYmPf8wkLWWO6742KunX+5ywA0RNw+YW
 OZM6hPu1FT4gsu1QWBKQD1P7gs2w5Qq5E5M= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hdwna9q47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 10:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlDbaSWqh+FPYz33tgilXdD6GYHvQACnFAnMnOXJuKTAZK1Okh4n3ZUXSZQfwLK94eqAg7+H4rq26NVzfmjimuFaYozpBYYE9RD210MKC0kWVBzbXyb8x77NrcBy5EGPEiptf71XT/gWWb4Vg4/qFT97GSHYyW/x2EANxi5rX5KG00kBsBl3Fdl3shqq0Egy9FRTkZgYat+ohbcAOZ8kVxllykeXbH0AX5gbjLhb9KZ+LMpPVEZlVXJPcC7hib03HZ+HaoPYRcNOhX9Tzsu93haNQ+wJ84PvL9ohTZcved1vypMvZ3pqbPxrNIH4VPFdEDW9XOG9JVik4IauHNZvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqzw423u3WoxACEKX5y6ghpnXDd7JdKRUwp2nLJhQRU=;
 b=RP0SlZJEnE/o83q3x+V4S0G6XZSYYmiEWPtunbrV4FsV9qA2srlvkFh49yWsLlHXmZh3UWcn64oy+IIrj/V63f7zXMh/E4Jv4JpZybRNFTLgdF+Qm/MIeGMsk6RHWvG0qGhsCAJfL4GbQCxqP4Tw+ExfiS+2K6OPCIVxXgk22xiHr+lKnUi2MQYUcpiVidOf/t1HBYstt7exgyUfcv08lHfehEsDQtoJUoJXJWTiOB+4/OyI+55J/Bb9M+eVnVxGRPhTLAP8HfxKWWkYV9othpfPSbaMmqfuaM+Aa6gM+P1tgIO79t0XygRqHlAOLh52G4PJSu3N0UznYyC7Nu7XSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MWHPR15MB1744.namprd15.prod.outlook.com (2603:10b6:301:4e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 17:19:06 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:19:06 +0000
Date:   Tue, 19 Jul 2022 10:19:02 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
Message-ID: <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
References: <YtZ+/dAA195d99ak@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZ+/dAA195d99ak@kili>
X-ClientProxiedBy: BYAPR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::17) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505c4cfb-1b3d-43eb-c3f8-08da69aac8ad
X-MS-TrafficTypeDiagnostic: MWHPR15MB1744:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLH5gtRA8udceYlV8+BsRu9VjbykRnoLnb97AW7P0ioHEoH74I/v7GPRQYNbbi5biuSEy+O8PgXflu5ofh8Smuwfuu5xG5tePIg+0JegMnIilpliNJTf5Nd6nMpg6xHObyOLTrEj73wSQdnS7fFzIfGYEd+qnsZ2MwXfSF6usJq2mMb9dj+PRc5FQkyBpBV9gwr2k/ysZy/EWlHoa2W55n1jpRc8lAa51wmT57NxcGyXxQ6TAMrOeEEdNkg5o4YeN+roZXNKc7ciVzc21944SWrXpEKM1tCrmkW9b13zIxT7M0IDS1SOzNW0YMiIe1DD26K9RUQu9xBHEZgpPX58SJGL48dt0fVu+5bI8OJBm8nJ/U9tuyOo+Lh+PIvWkZcGtpONN7jI0jmpXmydTFZN0W/vSCewxsqfWxl/2d4UPsKLyIZaZjnKjt/XcLyyJ28dCtkt2psVWpoAxqY1bQLoEt8aZS/dFLf3RE/2x7xz1xAZTWyE1v+0sSJq8gvh5DP1G+r7n8JXLXLBfc/JV+5NSxtFGxJYLnhAt7cXQjlr5349LReOAV2k++e6g9dpcmwFJckpYuow//HyILdAqB3ksK55hR4GHk7ZVtTInzRi3M2N6TWZkSkPWgtFYx1o2l0BnQA92b3f+IjXwUmmQ3Nd9PdBpqylK3skj3xCZwOch6QwafAkjblzBJUZLYMTGq3UzBMFWDETuQkGNnDBg3bNAYPl18fn9NHSp5QQhwNSgI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(41300700001)(83380400001)(6486002)(478600001)(1076003)(6666004)(6512007)(316002)(186003)(52116002)(38100700002)(6916009)(66476007)(66946007)(66556008)(8936002)(4326008)(5660300002)(7416002)(54906003)(2906002)(6506007)(86362001)(9686003)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KtFgLq18y6jdDi2CZwkWb+1j8NRrPdfQWO1RRQmSPPlo+14/O5RRAukXIuDK?=
 =?us-ascii?Q?j7GiVAnEhm7KKyFFgdnxc4fV5avaAEV+UlbC2gRTn7g7yjVKfj2x4zzUdlwD?=
 =?us-ascii?Q?KeHohBY0d6dyiXhZZmSrhV2Pq2xXoRPGP44V5fnhnFT7BYshwQNhrSEGLocf?=
 =?us-ascii?Q?/Y465mxEUehm5U6v7LcYiHREyjcTggK2EdZuYL5tyRaWcuFjiYMzD6eVcXXy?=
 =?us-ascii?Q?x11h1kcfpQx7S+OkliAeVH9CTnzNUqt167TDzT0BdE5w+y0+WdqmZLLAdXFM?=
 =?us-ascii?Q?s2UxdUrbAfO1y0ztORtCVX84zQ9/2EGfX1O3dhQzhI1Ead0yB5THYts0+3tK?=
 =?us-ascii?Q?NXRmNs+Yz17S4v4jxNJWsdnpx1jjOGggExvwSHGl0VYC+HHySwYzfaHX6NpK?=
 =?us-ascii?Q?Sjr7BY+K1WpRHF+52H27ki7ppUhGi8E1xtb8i7iplteQ4NepMWSHbL9I3lL4?=
 =?us-ascii?Q?95WzAGqnBuxV7vWgiuuAM5ks/HuwwhVRyVwgG4TkZYCFlJ15JaWaHRDn+oFx?=
 =?us-ascii?Q?hVaWx5WICQwkYoUwFvtNGk0RCoYJooVo/B6x1kvMkBP5CNqaFBtyk2xdqbIt?=
 =?us-ascii?Q?n/5ZGoU1AblRyk5Ww/h2ZRnwaSEgUnBuVxAk7NE341kB0I0LLTEYRLVqGVXt?=
 =?us-ascii?Q?C388aGffSx8qZFMpnM0oxxt0dve+LdmoSayUqfhUcZWEqkKENPuqeac++65i?=
 =?us-ascii?Q?02E0xiOXEaVvw8dBYQYC/oU+2FWqjfUPJ+3H0r/RWwHbT+le1C0rQRmnlsK2?=
 =?us-ascii?Q?Nu2GV44s8pxJ904ujGoGuLvsLnhcETrnll/Ct5XnMUsE05pexazItGyIr4Kt?=
 =?us-ascii?Q?A+s12xG6jMr0cSUDeYbJGfmIhAK3xBD/4E2zSEehRy9aYykOMDLpCKthMzr2?=
 =?us-ascii?Q?BxOpYlNRZZY3fgilE0ZvuDdsSFmzUluaXhO9DUSIWXRCUorD94AdBfvdQeK8?=
 =?us-ascii?Q?k7A1I/iSa4RYLSe4kBRhAto2IBoH3yYmuj1UxF/9BUTn0sBNHd3zczdrU84y?=
 =?us-ascii?Q?xBEDP0d8KIqsdVVwoZ3wCoz7YDJVUw3GKGVOSF9aCWcEe3DgUuIyaTzgHXlE?=
 =?us-ascii?Q?n0DZlS1esN93a6+1qbdF3YcB+se+2EZyXM1DB7IZYbF6C7jo9TZJBeOk93RJ?=
 =?us-ascii?Q?SFqXMl57O4rHSYevRLIUxktZ1Vca0mEofBGGCmf0ddr39znN4IqRMBnyHVtK?=
 =?us-ascii?Q?Sx7DmbC4v4hp2zvlwYwm69KHRbR9w7Hd6J8aB2fSlevvJUO/VMg3s0VzN+dd?=
 =?us-ascii?Q?8/UpM8taFwyKtxH97XHEDT9IO3OFzqrKV0STnkJk6MX4/XbN3MBjIyH604IK?=
 =?us-ascii?Q?KeqHTyY3fERfwQ3X01nUscsVOHdub8XCibjRo5PWu+ArakZ9PUMc44bJywU8?=
 =?us-ascii?Q?Bm4+dpIV6g/wp6EdeKeXA9SjHQ1+mePtGy3jHmBo8L5N/5fza3nx6USXj18i?=
 =?us-ascii?Q?b1WCh5CYAGdA/GDItKii0pr2wZEwZ8wkfRtdTE8gcDHqj5nF0tNKyQMIzvpF?=
 =?us-ascii?Q?djCZqRNcOxnb6XdojHTjq4p1qbuabFtYM/zKhwzPsTAEtLHqsJ8IJlq7l4Tc?=
 =?us-ascii?Q?ODP4LExmqp1XnrZvD+uIerkeFmewgQBvFllILo7vG0fdidxAaUeQlLL24mha?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505c4cfb-1b3d-43eb-c3f8-08da69aac8ad
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:19:06.0565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32oIExkffmGm3wR8UJujbcaGt5famOu1LmsSdp+qGaywtcPA+AH9m+YObMQ0kbEc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1744
X-Proofpoint-ORIG-GUID: m3fxY3ADKSmsuoqnTD1kexu6nihgiXTw
X-Proofpoint-GUID: m3fxY3ADKSmsuoqnTD1kexu6nihgiXTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 12:53:01PM +0300, Dan Carpenter wrote:
> The return from strcmp() is inverted so the it returns true instead
> of false and vise versa.
> 
> Fixes: a1c9d61b19cb ("libbpf: Improve library identification for uprobe binary path resolution")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Spotted during review.  *cmp() functions should always have a comparison
> to zero.
> 	if (strcmp(a, b) < 0) {  <-- means a < b
> 	if (strcmp(a, b) >= 0) { <-- means a >= b
> 	if (strcmp(a, b) != 0) { <-- means a != b
> etc.
> 
>  tools/lib/bpf/libbpf_internal.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 9cd7829cbe41..008485296a29 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
>  	size_t str_len = strlen(str);
>  	size_t sfx_len = strlen(sfx);
>  
> -	if (sfx_len <= str_len)
> -		return strcmp(str + str_len - sfx_len, sfx);
> -	return false;
> +	if (sfx_len > str_len)
> +		return false;
> +	return strcmp(str + str_len - sfx_len, sfx) == 0;
Please tag the subject with "bpf" next time.

Acked-by: Martin KaFai Lau <kafai@fb.com>
