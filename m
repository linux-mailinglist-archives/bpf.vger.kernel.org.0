Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C2621AA4
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 18:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiKHRbB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 12:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbiKHRa7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 12:30:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D11D0EC
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 09:30:58 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8EtZfQ029499;
        Tue, 8 Nov 2022 09:30:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6o93AuCgK69DXd+9iKadcPVtYfSRUf74jFpm8Mij3e8=;
 b=fNMv5lLOT5WS3zKGETl94sP+UemUonPM1X3FMbQxhpSqGx3WZ5Qid4fK+wI3ZMdwLSnM
 9V3pLyjYA7SKAMwQvoknp3WDrvFtfHdom8ZnIj7QoFjqhKm56kNg5dx2OiahgW7Ckcxu
 Vpkrh0qzNRAdKIjflDdC7Pc4ilQLVRNO7ei4hXHLuZcmZRN3zJ4FQ3UOUJbb5CsKYmwW
 E3dZ55dJ2LjppnX2eGz+u3Fo0Bucvi3VBmNAgo/Q1l2PKBurq/yhrrMtuCZYguemzsrT
 +MS96cDhAO+VVt3s9IP+7xgHLkJzstfnpVhTZxBOH16myYJNF/0X2jieFxAMdR2EpWI3 Zw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kqcc5pxw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 09:30:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiVi/dB/sjDdVme9SgoXLOmIMl5vOEVSbJ08FlS8lFxRpBFNNhIDRyHkpEgm24yNNrdDAXggcuTEWO+mVjZng+qcGOH+JHQ2/NsIlqWLmF6bZ4yV/NrGF6yNpZPHYgJuhRiSZJqXcPchd2J1rAMOp2TqNwHs46X3Xf7TPOoyUoqEQJYubT/MUKkabqNCH59Vrun/M+H51iEUtuorCbCtmeztYPng6TnhXSQ3rTve/wY+aB2bIMjk3QFe6lvOb5idzzxGbwoOEEmUL1bmP/i5GKY9kcp5lVV1r77goYnJUbwb++idmMD7WHHybjsiJSEvZz8eXUNtQ+gc2F+uuQbaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o93AuCgK69DXd+9iKadcPVtYfSRUf74jFpm8Mij3e8=;
 b=Pe1Vm4ETPADCQ0NpKYZ85tbvCSTvfSkj8p01FJQ9LCGy1pG9MiTjjhSJDuk5eahAkC1QBHS4taGhn3aArJZ+WUmgvafvW1C7HWfNj6jhKKHMgkX66GquAHLtN0OCmoNOkXi0brpxSISmrj+FDhifiFsflwYYdc7lkBz3gQb3BxVJf9kv6ueF5ONJEey1YAMOkzt9DdkaQhDYj5F76J50A2G2ukGEKAPMIEujwTyjaq97neHQfF1M1S5GxQK62Dz1hSQtp2bpjmOldMCplrlM9aTqKpErmf6Zc7B84BnmvnacjusS6ulfIgqcnEV+X791RrtuO2H/c9o2L0P9Kz68QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2629.namprd15.prod.outlook.com (2603:10b6:a03:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 17:30:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:30:22 +0000
Message-ID: <8823a169-f771-7e7f-6224-fda214b3861b@meta.com>
Date:   Tue, 8 Nov 2022 09:30:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/4] bpftool: remove support of --legacy option for
 bpftool
Content-Language: en-US
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
References: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
 <20221108142515.126199-2-sahid.ferdjaoui@industrialdiscipline.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108142515.126199-2-sahid.ferdjaoui@industrialdiscipline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0254.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2629:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c9ceff-2f4a-4a98-55c8-08dac1aeea2e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Ds5E0EqjhPbX7QTEsJftOAuJ74PWXTqHXsLNzUs6HxVvQsUc6FVrxYr6bfONy4CQmCWmnF7iynnyuawudbH97vyleSVD5p2yUw8CHHhCh5p6e3TO0lFIHEjspuqLWc4VR3NNIiuOYty6h8/nSVPEwnDQZc/rQiJS0rzSuXw1emfQj/VWpAcekYTGquqMG3GBFM9idObVEn/fumuo4d1x7wKUM/61UVAspSApIaXpwM+QiyfKGmgfGXqgC59Sgl4Vb/p69vdPTdnUCf6QGlYLGUbVcOY0pe6J8nY0PEiByR3SI5I3m+u9h7//PFhDrOq09G/2XtMPVj3tJOj9BH6+UsV/bX7EzEc+DYHM8NVKXIboXQydKDoXi93zLzQJGTDg6SELwUtEYnN6SYrcYlG7clfXbz+9W5lXwQt7zZZ8aHCPftdm+Xy6Oo12WimysdPobDTr3dNZFtc2yKASxpGriVmXS/DdwoHS+y8ov8u9z+pAkg0vgse0zbOE1JCAuePUvhK8kk57OdTV41Ui5zXl792dJoocL98GEnx4jzHflEg5R3CVNtUxFQaV7134Hy0ThXCvxfqlxOY+hpOXiUQjOGTXAPIe2fp19OrYp8YuZP+3KtiKwvtTls4DMt2dLyENXvBL72k9yTstHHW6rypA9wtLiXNHY7JqZ+NaSKbl/jmORgSNA2nlxHzivI6zYPF2yMHbbQiKeNqggxxtMMR8g+26r7gvHD6gI+DPi+Xf2WIRdWcWNj20Z75NvG8gjxA079PpSsMqNcpqxuIWAWxGtX+1hNEY+2a3UZrf3IHFYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(31696002)(316002)(86362001)(38100700002)(6486002)(66556008)(4744005)(2906002)(41300700001)(2616005)(66946007)(8936002)(8676002)(66476007)(186003)(7416002)(478600001)(4326008)(6666004)(5660300002)(6506007)(6512007)(53546011)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0ZrSEM5THJPU3dDNWs4UXg2cVMvc0huWEoyMjd3WGxFZ2pPS3FWcGVPdkZm?=
 =?utf-8?B?OStuenlaRG1PRzc5eEdzL3JOUDhsQ053ZW9xSTRHa0dGOGkvVHBRcWdFREpn?=
 =?utf-8?B?cC9ZRktRci9Oa0ZIbUNiZ1J3aEM1Q1hIcWNmQ09JR3N1N1BQbm4rc2VhK1Vr?=
 =?utf-8?B?Q1FVN2JwdDdYZW9ZQUNaUXBXZHdmTDdHV3dyalkyalNqM1F4ajBVQXdRcnRI?=
 =?utf-8?B?cVBLT1UrK05UT2xqZEtuVlliT0N3WHdsZEpoWElTMzg4QUlwS0FqVWF1TW5k?=
 =?utf-8?B?V1hQc214bzF2WUlWd2ptdzhoU2t5MmJaVHJMbHhoZUNnVkNPMFRiZ01ZK0RF?=
 =?utf-8?B?RklTa21TTk15YkVMZzlOb2IvS1QxdHl1ME13V2xrRE1nYmsxWEFrdC83VmF6?=
 =?utf-8?B?Ym9vQUVWT0tGZXBlNTE0YzRXYzZmbnpEM1JSMGxLYVlHNW1ZdlpNdDNWSkgz?=
 =?utf-8?B?R0h5alg5L29VaHhEL04xbEpFUGxRcDh5VjViQ2pIUldhTFhQbG1JV2ZkcWw2?=
 =?utf-8?B?YUorektreGpyUHpGV1NseFg3dEJDeUdMeDkwRzZMenNJeUZkOHZWaWxCUkZE?=
 =?utf-8?B?YnZvT1IxRjFCRDVtZlhUcXNqMlI0bTBvdklSODZqays5OU5Tc24yM0Rkd3RX?=
 =?utf-8?B?SlZ2aFJtWGJUOWcyVTVKWllHYVUvWjZRdktHcmpQQ0J3R1hiMlZzYm12VzUr?=
 =?utf-8?B?OWdSYnN3cnB2aEUxckRuNXpVdXF1NXhMZWM0bnd1MHI1TFd1dTBzMmZjL2VI?=
 =?utf-8?B?Y3dmaUFWM2hZbGE1WnZ6VnNHZURjM3N4QmFEeDQ5d2lXZnJJUm5FZVljZ3M5?=
 =?utf-8?B?bzF3WUZSM1VjdDFzU1dTTWkzTzgvSE02THg0RkpEV2NmVDNuUmFhTUhWMVRu?=
 =?utf-8?B?Q20yRm9QM2p5WUpHZFFXcmpuMUh5aC9oSXdnVTNBOGZ5Y0RCZ3VSMTk2L3li?=
 =?utf-8?B?N1VhSmRCOFl1a1dHL1VMNmZZQlFmYmRRY2hSZEE1Ym9BUkZ0aGEvMWpYQzlF?=
 =?utf-8?B?N1RmNjRXQUpUZFVDVkJCVGxXem5ZT0tiRm5tbWtiUXZRbG5wcFNiZDVmTndj?=
 =?utf-8?B?YzF5dE5JcldsMk81QVlkQVpiTFVzR1RXeEJUUExXdWVWOXkvZDV6aGhqSHJn?=
 =?utf-8?B?eFdmSWZ0OUxBV0V3U1V2RjJ6cHVPRnVKWS9ZeGFJS1htMkhpdnlkMHdRR2tT?=
 =?utf-8?B?cDFjSjdaL2h0UmNJOFlBelBTU1RjLzhKdE1SMCtBK2d5WTRaOWxaTWhTU0hJ?=
 =?utf-8?B?VzZMd0JSREhySUVtaXJLak1ObXQzUzhnaTIwMnJodUpCdnFNMHRSR3hPVXBF?=
 =?utf-8?B?Vi9aRG8xYi9vRVB6SDluMEIwUSt6c2JLdmpxUnZZcmYwM2FMOEZwYWt5VkNt?=
 =?utf-8?B?ZHVHL0xyVjJlT0ZXQkhPdjVaNDJpZ2tYejFPUGRIb2cvZXkzK05JRWdiZWFp?=
 =?utf-8?B?aW5uNm1pNjYwbFpEbmZGWTNCaXplN3JxWlpMVS9MZkhNSk91eXNCUE14Q3J0?=
 =?utf-8?B?K0tRNFVodlJ0bUQ5VWt1V1hRV25IR0hkbzM5MkR3SW9kNzR6dUhLUkYxK0M1?=
 =?utf-8?B?cXpLYjR4YVUyZkgvUFlmcGlUWE1VQWxiV0hnU3NxYmNrZGxqcUhYNW1vd1hr?=
 =?utf-8?B?OHJ1UHgxL1Z1MHNjeWFPamZ3aXorVHBMa2RGZFhaYjZ0MHZ0RE80TGRpbVpi?=
 =?utf-8?B?VFJ6cEk1Y3F3cFlqakhwZlpmbWxHQThCU3ZYOVp4YWdkSC9nUENOa0djNTBC?=
 =?utf-8?B?djZjNjl6SDNqSUJYSVBsNVRzWG4zQ1NtclZLalE5WXV4QTg0MkpzcFZ6NE94?=
 =?utf-8?B?WTdnRDBGU0ZDMUZvdkhrQ3N6UGhGM3Fxa0ZISlZ4eHBRbitQcTNoYmNNTFVS?=
 =?utf-8?B?ME5xdnF0dmg3RGNRT0J2c0NNblBZYW53VFgrMHdSWEFWbzlMYm90RVBNWmR1?=
 =?utf-8?B?S2diTEx4QVFYWEFpbjQ3RDdBL1NveHFMbkozRXU3MUFmM2JUYTV4akY0QStK?=
 =?utf-8?B?ZS9zaThxYnJIaHgvSjZYS1AxT1hGL1REdFlHZWZJazR4T3JyazFuM2tDRi9s?=
 =?utf-8?B?M1dSMFhYVWUxeFdzRUJQWDFPU0dGM20wS0dRUiszZDVLQnBVYjF3WFY3UVRJ?=
 =?utf-8?B?WVErWEFVQnlHb2xyS0hlb1ZNdWQ3OUxxRG83NWZiR0JmWmFhdW5ZYzJ2dlJL?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c9ceff-2f4a-4a98-55c8-08dac1aeea2e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:30:22.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQSfSd/kl3N4NR5gxlnpYx8wr+A/URjZTEtPUZtZrohLZDZHWAJxW8umme/NCJ0D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2629
X-Proofpoint-ORIG-GUID: 0TXqlKpO4oPxyapPK5VXLFpZ8825P6LH
X-Proofpoint-GUID: 0TXqlKpO4oPxyapPK5VXLFpZ8825P6LH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 6:27 AM, Sahid Orentino Ferdjaoui wrote:
> Following:
>    commit bd054102a8c7 ("libbpf: enforce strict libbpf 1.0 behaviors")
>    commit 93b8952d223a ("libbpf: deprecate legacy BPF map definitions")
> 
> The --legacy option is no longer relevant as libbpf no longer supports
> it. libbpf_set_strict_mode() is a no-op operation.
> 
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>

Acked-by: Yonghong Song <yhs@fb.com>
